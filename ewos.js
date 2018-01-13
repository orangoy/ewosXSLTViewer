$(document).ready(function () {
    $('.qualitysamples').DataTable({
        "dom": 'Bfrtip',
        "buttons": [
            'copy', 'csv',
            {
                extend: 'excel',
                title: 'Quality Samples'
            }
        ]
    });
    $('.qualitysamples').show();
    $('.feedtable').DataTable({
        "pageLength": 5,
        "lengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
        "dom": 'Bfrtip',
        "buttons": [
            'pageLength',
            'copy', 'csv',
            {
                extend: 'excel',
                title: 'Feeding'
            }
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
                pageTotalFeed.toLocaleString() + '<br/>' +
                pageFilteredFeed.toLocaleString() + '<br/>' +
                totalFeed.toLocaleString()
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
            'copy', 'csv',
            {
                extend: 'excel',
                title: 'Biomass per group'
            }
        ],
        "pageLength": 5,
        "lengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
        "language": {
            "decimal": ".",
            "thousands": ""
        },
        "columnDefs": [
            {
                targets: [0, 1],
                render: $.fn.dataTable.render.moment('YYYY-MM-DD', 'DD.MM.YY'),
                className: 'dateCols'
            },
            {
                targets: [2, 4, 6, 8, 10, 12],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 0),
                className: 'countCols'
            },
            {
                targets: [3, 5, 7, 9, 11, 13],
                type: "num-fmt",
                render: $.fn.dataTable.render.number(' ', ',', 0),
                className: 'kgCols'

            }
        ]
    });
    $('.envtable').DataTable({
        "dom": 'Bfrtip',
        "buttons": [
            'pageLength',
            'copy', 'csv',
            {
                extend: 'excel',
                title: 'Records'
            }
        ],
        "pageLength": 5,
        "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
        "language": {
            "decimal": ".",
            "thousands": ""
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
