$(document).ready(function () {
    $('.qualitysamples').DataTable({
        "dom": 'Bfrtip',
        "buttons": [
            {
                extend: 'excel',
                title: 'Quality Samples'
            },
            {
                extend: 'csv',
                title: 'Quality Samples'
            },
            'copy'
        ]
    });
    $('.qualitysamples').show();
    $('.feedtable').DataTable({
        "pageLength": 5,
        "lengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
        "dom": 'Bfrtip',
        "buttons": [
            'pageLength',
            {
                extend: 'excel',
                title: 'Feeding'
            },
            {
                extend: 'csv',
                title: 'Feeding'
            },
            'copy'
        ],
        "footerCallback": function (row, data, start, end, display) {
            var api = this.api(), data;

            // Remove the formatting to get integer data for summation
            var intVal = function (i) {
                return typeof i === 'string' ?
                    i.replace(/[\, ]/g, '') * 1 :
                    typeof i === 'number' ?
                        i : 0;
            };
            totalFeed = api
                .column(3)
                .data()
                .reduce(function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0);
            // Total over this page
            pageTotalFeed = api
                .column(3, {page: 'current'})
                .data()
                .reduce(function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0);


            pageFilteredFeed = api
                .column(3, {filter: 'applied'})
                .data()
                .reduce(function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0);

            // Update footer
            $(api.column(3).footer()).html(
                pageTotalFeed.toLocaleString(undefined, { maximumFractionDigits: 2}) + '<br/>' +
                pageFilteredFeed.toLocaleString(undefined, { maximumFractionDigits: 2}) + '<br/>' +
                totalFeed.toLocaleString(undefined, { maximumFractionDigits: 2})
            );
        },
        "columnDefs": [
            {
                targets: [0, 1],
                render: $.fn.dataTable.render.moment('YYYY-MM-DD', 'DD.MM.YY'),
                className: 'dateCols'
            },
            {
                targets: [3],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 0),
                className: 'kgCols'
            }

        ]
    });
    $('.periods').DataTable({
        "dom": 'Bfrtip',
        "buttons": [
            'pageLength',
            {
                extend: 'excel',
                title: 'Biomass per group'
            },
            {
                extend: 'csv',
                title: 'Biomass per group'
            },
            'copy'
        ],
        "pageLength": 5,
        "lengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
        "language": {
            "decimal": ".",
            "thousands": ""
        },
        "footerCallback": function (row, data, start, end, display) {
            var api = this.api(), data;
            // Remove the formatting to get integer data for summation
            var intVal = function (i) {
                return typeof i === 'string' ?
                    i.replace(/[\, ]/g, '') * 1 :
                    typeof i === 'number' ?
                        i : 0;
            };
            var counts = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
            var countCount= counts.length;
            for (var i = 2; i < countCount; i++) {
                $(api.column(i).footer()).html(
                    api.column(i).data()
                        .reduce(function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0).toLocaleString(undefined, { maximumFractionDigits: 2})
                );
            }
        },
        "columnDefs": [
            {
                targets: [0, 1],
                render: $.fn.dataTable.render.moment('YYYY-MM-DD', 'DD.MM.YY'),
                className: 'dateCols'
            },
            {
                targets: [2, 4, 6, 8, 10, 12,14],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 0),
                className: 'countCols'
            },
            {
                targets: [3, 5, 7, 9, 11, 13, 15],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 0),
                className: 'kgCols'
            },

        ]
    });
    $('.envtable').DataTable({
        "dom": 'Bfrtip',
        "buttons": [
            'pageLength',
            {
                extend: 'excel',
                title: 'Records'
            },
            {
                extend: 'csv',
                title: 'Records'
            },
            'copy'
        ],
        "pageLength": 5,
        "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
        "language": {
            "decimal": ".",
            "thousands": ""
        },
        "footerCallback": function (row, data, start, end, display) {
            var api = this.api(), data;
            // Remove the formatting to get integer data for summation
            var intVal = function (i) {
                return typeof i === 'string' ?
                    i.replace(/[\, ]/g, '') * 1 :
                    typeof i === 'number' ?
                        i : 0;
            };

            var Temp = api.column(2).data();
            avgTemp = Temp.reduce(function (a, b) {
                return intVal(a) + intVal(b);
            }, 0) / Temp.length;


            var Oxy = api.column(3).data();
            avgOxy = Oxy.reduce(function (a, b) {
                return intVal(a) + intVal(b);
            }, 0) / Oxy.length;

            countWs = api
                .column(5)
                .data()
                .reduce(function (a, b) {
                    console.log(b);
                    if(b === "true") return intVal(a) + 1;
                    else return intVal(a);
                }, 0);

            // Update footer
            $(api.column(2).footer()).html(avgTemp.toLocaleString(undefined, { maximumFractionDigits: 2}));
            $(api.column(3).footer()).html(avgOxy.toLocaleString(undefined, { maximumFractionDigits: 2}));
            $(api.column(5).footer()).html(countWs.toLocaleString());
        },


        "columnDefs": [
            {
                targets: [0, 1],
                render: $.fn.dataTable.render.moment('YYYY-MM-DD', 'DD.MM.YY'),
                className: 'dateCols'
            },
            {
                targets: [2],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 2),
                classname: 'tempCols'
            },
            {
                targets: [3],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 0),
                className: 'countCols'
            }

        ]
    });
});
