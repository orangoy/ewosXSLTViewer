<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html>
        <head>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" />
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js" />
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />
            <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" />
            <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js" />
            <script src="https://cdn.datatables.net/plug-ins/1.10.16/dataRender/datetime.js" />
            <!-- for Export buttons: -->
            <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css"  />
            <script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js" />
            <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js" />
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" />
            <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js" />
            <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js" />
            <!-- Local stuff: -->
            <link rel="stylesheet" href="ewos.css" />
            <script src="ewos.js" />
        </head>
        <body>
            <xsl:for-each select="Export">
                <div class="export">
                    <div class="start_date"><b>From date: </b><xsl:value-of select="StartDate"/> </div>
                    <div class="end_date"><b>To date: </b><xsl:value-of select="EndDate"/> </div>
                <div class="export_source"><b>Export source: </b><xsl:value-of select="ExportSource"/> </div>
                <div class="export_destination"><b>Export destination: </b><xsl:value-of select="ExportDestination"/> </div>
                <div class="export_version"><b>Export version: </b><xsl:value-of select="ExportVersion"/> </div>
                <div class="export_date_time"><b>Export time: </b><xsl:value-of select="ExportDateTime"/> </div>
                </div>
                <xsl:for-each select="Companies/Company">
                    <div class="well well-sm">
                    <div class="company">
                        <h3>
                            <div class="company_name"><xsl:value-of select="CompanyName"/></div>
                            <div class="organization_number">
                                (
                                <a href="https://w2.brreg.no/enhet/sok/detalj.jsp?orgnr={OrganizationNumber}"><xsl:value-of select="OrganizationNumber"/></a>
                                )
                            </div>
                        </h3>
                    </div>
                        <xsl:for-each select="Sites/Site">
                         <div class="well well-sm">
                         <div class="site">
                            <div class="site_name"><h4><b>Site name: </b><xsl:value-of select="SiteName"/></h4></div>
                             <div class="site_number"><b>Site number: </b><xsl:value-of select="SiteNumber"/></div>
                             <span class="position"><b>Position: </b>
                             <a href='https://www.google.com/maps/search/?api=1&amp;query={Latitude},{Longitude}'>
                                <div class="latitude"><xsl:value-of select="Latitude"/></div>
                                <div class="longitude"><xsl:value-of select="Longitude"/></div>
                             </a>
                             </span>
                             <div class="max_allowed_biomass"><b>Maximum allowed biomass: </b><xsl:value-of select="MaxAllowedBiomass"/></div>
                             <div class="last_date_of_registration"><b>Date of last registration: </b><xsl:value-of select="LastDateOfRegistration"/></div>
                             <hr/>
                          </div>
                            <div class="btn-group" role="group" aria-label="Buttons">
                                <xsl:if test="Groups/Group/Periods/Period/MovedOut/TransferDetail">
                                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#transfer_collapse{generate-id(SiteID)}" aria-expanded="false" aria-controls="transfer_collapse{generate-id(SiteID)}">
                                    Transfers
                                </button>
                                </xsl:if>
                                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#group_collapse{generate-id(SiteID)}" aria-expanded="false" aria-controls="group_collapse{generate-id(SiteID)}">
                                    Biomass
                                </button>
                                <xsl:if test="Groups/Group/Periods/Period/Feed/FeedingDetail">
                                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#feed_collapse{generate-id(SiteID)}" aria-expanded="false" aria-controls="feed_collapse{generate-id(SiteID)}">
                                    Feed
                                </button>
                                </xsl:if>
                                <xsl:if test="Groups/Group/Periods/Period/QualitySamples/QualitySample">
                                    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#qs_collapse{generate-id(SiteID)}" aria-expanded="false" aria-controls="qs_collapse{generate-id(SiteID)}">
                                        Quality Samples
                                    </button>
                                </xsl:if>
                                <xsl:if test="Groups/Group/Periods/Period/AverageTemperature">
                                    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#env_collapse{generate-id(SiteID)}" aria-expanded="false" aria-controls="env_collapse{generate-id(SiteID)}">
                                        Environment and records
                                    </button>
                                </xsl:if>
                            </div>
                            <!-- Quality Samples  : -->
                            <xsl:if test="Groups/Group/Periods/Period/QualitySamples/QualitySample">
                                <div class="collapse" id="qs_collapse{generate-id(SiteID)}">
                                    <div class="card card-block">
                            <h4>Quality samples</h4>
                            <table class="qualitysamples">
                            <thead>
                                <tr>
                                    <th>Group</th>
                                    <th>Period end</th>
                                    <th>Sampled date</th>
                                    <th>Individs</th>
                                    <th>Astaxanthin</th>
                                    <th>La Roche</th>
                                    <th>SalmoFan</th>
                                    <th>Fat</th>
                                    <th>Live weight</th>
                                    <th>Condition factor</th>
                                    <th>Total length</th>
                                    <th>Gutted weight</th>
                                </tr>
                            </thead>
                            <tbody>
                            <xsl:for-each select="Groups/Group">
                                <xsl:for-each select="Periods/Period">
                                    <xsl:for-each select="QualitySamples/QualitySample">
                                    <tr>
                                        <td class="qsample_group"><xsl:value-of select="../../../../GroupName" /></td>
                                        <td class="qsample_period"><xsl:value-of select="../../LastDay" /></td>
                                        <td class="sample_date"><xsl:value-of select="SampleDate"/></td>
                                        <td class="individs"><xsl:value-of select="Individs"/></td>
                                        <td class="astaxanthin"><xsl:value-of select="Astaxanthin"/></td>
                                        <td class="la_roche_a"><xsl:value-of select="LaRocheA"/></td>
                                        <td class="salmofan_a"><xsl:value-of select="SalmofanA"/></td>
                                        <td class="fat"><xsl:value-of select="Fat"/></td>
                                        <td class="weight_living"><xsl:value-of select="WeightLiving"/></td>
                                        <td class="condition_factor"><xsl:value-of select="ConditionFactor"/></td>
                                        <td class="total_length"><xsl:value-of select="TotalLength"/></td>
                                        <td class="weight_gutted"><xsl:value-of select="WeightGutted"/></td>
                                    </tr>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                            </tbody>
                            </table>

                                    </div>
                                </div>
                            </xsl:if>
                            <!-- Groups and periods : -->

                             <div class="collapse" id="transfer_collapse{generate-id(SiteID)}">
                                 <div class="card card-block">
                                     <h4>Transfers</h4>
                                     <table class="transfertable">
                                         <thead>
                                             <tr>
                                                 <th class="to_site_id">Period end date</th>
                                                 <th class="to_site_id">From site name (ID)</th>
                                                 <th class="to_site_id">From group  / unit (ID)</th>
                                                 <th class="to_site_id">To site ID</th>
                                                 <th class="to_group_id">To group / unit (ID)</th>
                                                 <th class="transferred_individcount">Individ count transferred</th>
                                                 <th class="transferred_biomass">Biomass transferred</th>
                                                 <th class="transferred_individcount">Individ count after transfer</th>
                                                 <th class="transferred_biomass">Biomass after transfer</th>
                                             </tr>
                                         </thead>
                                         <tfoot>
                                             <tr>
                                                 <th colspan="9"></th>
                                             </tr>
                                         </tfoot>
                                         <tbody>
                                             <xsl:for-each select="Groups/Group/Periods/Period/MovedOut/TransferDetail">
                                                 <tr>
                                                     <td><xsl:value-of select="../../LastDay"/></td>
                                                     <td><xsl:value-of select="../../../../../../SiteName"/> (<xsl:value-of select="../../../../../../SiteID"/>)</td>
                                                     <td><xsl:value-of select="../../../../GroupName"/> <xsl:value-of select="../../../../UnitName"/> (<xsl:value-of select="../../../../GroupID"/>)</td>
                                                     <td><xsl:value-of select="ToSiteID"/></td>
                                                     <td><xsl:value-of select="ToUnitName"/> (<xsl:value-of select="ToGroupID"/>)</td>
                                                     <td><xsl:value-of select="StockTransferred/IndividCount"/></td>
                                                     <td><xsl:value-of select="StockTransferred/Biomass"/></td>
                                                     <td><xsl:value-of select="../../EndStock/IndividCount"/></td>
                                                     <td><xsl:value-of select="../../EndStock/Biomass"/></td>
                                                 </tr>
                                             </xsl:for-each>
                                         </tbody>
                                     </table>
                                 </div>
                             </div>

                            <div class="collapse" id="group_collapse{generate-id(SiteID)}">
                            <div class="card card-block">
                            <h4>Biomass per group</h4>
                            <ul class="nav nav-tabs">
                            <xsl:for-each select="Groups/Group">
                                    <li><a data-toggle="tab" href="#{generate-id(GroupID)}"><xsl:value-of select="UnitName"/> (<xsl:value-of select="FirstDateOfInput"/>)</a></li>
                            </xsl:for-each>
                            </ul>
                            <div class="tab-content">
                              <xsl:for-each select="Groups/Group">
                                  <div id="{generate-id(GroupID)}" class="tab-pane fade in">

                                <div class="group well well-sm">
                                <div class="unit_name"><h4><b>Unit name: </b><xsl:value-of select="UnitName"/></h4></div>

                                <div class="group_name"><b>Group name: </b><xsl:value-of select="GroupName"/></div>
                                <div class="group_id"><b>Group ID: </b><xsl:value-of select="GroupID"/></div>
                                <div class="unit_volume"><b>Unit volume: </b><xsl:value-of select="UnitVolume"/></div>
                                    <!-- <div class="species_id"><xsl:value-of select="Species/SpeciesID"/></div> -->
                                    <div class="species_name"><b>Species: </b><xsl:value-of select="Species/SpeciesName"/></div>
                                    <div class="fishtypes">
                                        <xsl:for-each select="FishTypes/FishType">
                                            <!-- <div class="fishtype_code"><xsl:value-of select="Code"/></div> -->
                                            <div class="fishtype_textual"><b>Fishtype: </b><xsl:value-of select="Textual"/></div>
                                        </xsl:for-each>
                                    </div>
                                    <div class="strains">
                                        <xsl:for-each select="Strains">
                                            <div class="strain"><b>Strain: </b><xsl:value-of select="Strain"/></div>
                                        </xsl:for-each>
                                    </div>


                                <div class="inputdates"><b>Input period: </b>
                                <div class="first_date_of_input"><xsl:value-of select="FirstDateOfInput"/></div>
                                    –
                                <div class="last_date_of_input"><xsl:value-of select="LastDateOfInput"/></div>
                                </div>
                                </div>

                                <table class="periods">
                                    <thead>
                                        <tr>
                                            <th class="first_day">Period start</th>
                                            <th class="last_day">Period end</th>
                                            <th class="stocked_count">Stocked count</th>
                                            <th class="stocked_biomass">Stocked biomass</th>
                                            <th class="movedin_count">Moved in count</th>
                                            <th class="movedin_biomass">Moved in biomass</th>
                                            <th class="movedout_count">Moved out count</th>
                                            <th class="movedout_biomass">Moved out biomass</th>
                                            <th class="loss_count">Loss count</th>
                                            <th class="loss_biomass">Loss biomass</th>
                                            <th class="sold_count">Sold count</th>
                                            <th class="sold_biomass">Sold biomass</th>
                                            <th class="harvested_count">Harvested count</th>
                                            <th class="harvested_biomass">Harvested biomass</th>
                                            <th class="end_stock_count">End stock count</th>
                                            <th class="end_stock_biomass">End stock biomass</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th colspan="2"></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                <xsl:for-each select="Periods/Period">
                                  <tr>
                                    <td class="first_day"><xsl:value-of select="FirstDay"/></td>
                                    <td class="last_day"><xsl:value-of select="LastDay"/></td>
                                      <td class="stocked_count"><xsl:value-of select="Stocked/IndividCount"/></td>
                                      <td class="stocked_biomass"><xsl:value-of select="Stocked/Biomass"/></td>
                                      <td class="movedin_count"><xsl:value-of select="MovedIn/IndividCount"/></td>
                                      <td class="movedin_biomass"><xsl:value-of select="MovedIn/Biomass"/></td>
                                      <td class="movedout_count"><xsl:value-of select="sum(MovedOut/TransferDetail/StockTransferred/IndividCount)"/></td>
                                      <td class="movedout_biomass"><xsl:value-of select="sum(MovedOut/TransferDetail/StockTransferred/Biomass)"/></td>
                                      <td class="loss_count"><xsl:value-of select="Loss/IndividCount"/></td>
                                      <td class="loss_biomass"><xsl:value-of select="Loss/Biomass"/></td>
                                      <td class="sold_count"><xsl:value-of select="Sold/IndividCount"/></td>
                                      <td class="sold_biomass"><xsl:value-of select="Sold/Biomass"/></td>
                                      <td class="harvested_count"><xsl:value-of select="sum(Harvested/HarvestDetail/IndividCount)"/></td>
                                      <td class="harvested_biomass"><xsl:value-of select="sum(Harvested/HarvestDetail/GrossBiomass)"/></td>
                                      <td class="end_stock_count"><xsl:value-of select="EndStock/IndividCount"/></td>
                                      <td class="end_stock_biomass"><xsl:value-of select="EndStock/Biomass"/></td>
                                  </tr>
                                </xsl:for-each>
                                    </tbody>
                                </table>
                                </div>
                              </xsl:for-each>
                            </div>
                            </div>
                            </div>


                            <div class="collapse" id="feed_collapse{generate-id(SiteID)}">
                                <div class="card card-block">
                                    <h4>Feed</h4>
                                    <ul class="nav nav-tabs">
                                        <xsl:for-each select="Groups/Group">
                                            <li><a data-toggle="tab" href="#{generate-id(GroupID)}_f"><xsl:value-of select="UnitName"/> (<xsl:value-of select="FirstDateOfInput"/>)</a></li>
                                        </xsl:for-each>
                                    </ul>
                                    <div class="tab-content">
                                        <xsl:for-each select="Groups/Group">
                                            <div id="{generate-id(GroupID)}_f" class="tab-pane fade in">
                                                <table class="feedtable">
                                                    <thead>
                                                        <tr>
                                                            <th class="first_day">Period start</th>
                                                            <th class="last_day">Period end</th>
                                                            <th class="feed">Name of feed</th>
                                                            <th class="feed">Feed amount</th>
                                                        </tr>
                                                    </thead>
                                                    <tfoot>
                                                        <tr>
                                                            <th colspan="3" class="text-right">
                                                                Sum shown:<br/>
                                                                Sum in search:<br/>
                                                                Sum total:
                                                            </th>
                                                            <th class="text-right"></th>
                                                        </tr>
                                                    </tfoot>
                                                    <tbody>
                                                        <xsl:for-each select="Periods/Period/Feed/FeedingDetail">
                                                            <tr>
                                                                <td class="first_day"><xsl:value-of select="../../FirstDay"/></td>
                                                                <td class="last_day"><xsl:value-of select="../../LastDay"/></td>
                                                                <td class="name of feed"><xsl:value-of select="NameOfFeed"/> </td>
                                                                <td class="feed_amount"><xsl:value-of select="FeedAmount"/></td>
                                                            </tr>
                                                        </xsl:for-each>
                                                    </tbody>
                                                </table>
                                            </div>

                                        </xsl:for-each>
                                    </div>
                                </div>
                            </div>
                            <div class="collapse" id="env_collapse{generate-id(SiteID)}">
                                 <div class="card card-block">
                                     <h4>Environment records and weight samples</h4>
                                     <ul class="nav nav-tabs">
                                         <xsl:for-each select="Groups/Group">
                                             <li><a data-toggle="tab" href="#{generate-id(GroupID)}_e"><xsl:value-of select="UnitName"/> (<xsl:value-of select="FirstDateOfInput"/>)</a></li>
                                         </xsl:for-each>
                                     </ul>
                                     <div class="tab-content">
                                         <xsl:for-each select="Groups/Group">
                                             <div id="{generate-id(GroupID)}_e" class="tab-pane fade in">
                                                 <table class="envtable">
                                                     <thead>
                                                         <tr>
                                                             <th class="first_day">Period start</th>
                                                             <th class="last_day">Period end</th>
                                                             <th class="avgtemp">Average temperature</th>
                                                             <th class="oxygenvalue">Oxygen value</th>
                                                             <th class="oxygentime">Oxygen reading time</th>
                                                             <th class="weightsampleperformed">Weight sample performed</th>
                                                         </tr>
                                                     </thead>
                                                     <tfoot>
                                                         <tr>
                                                             <th colspan="2" class="text-right">
                                                                 Average:
                                                             </th>
                                                             <th></th>
                                                             <th></th>
                                                             <th>Count:</th>
                                                             <th></th>
                                                         </tr>
                                                     </tfoot>
                                                     <tbody>
                                                         <xsl:for-each select="Periods/Period/OxygenReadings/OxygenReading">
                                                             <tr>
                                                                 <td class="first_day"><xsl:value-of select="../../FirstDay"/></td>
                                                                 <td class="last_day"><xsl:value-of select="../../LastDay"/></td>
                                                                 <td class="avgtemp"><xsl:value-of select="../../AverageTemperature"/></td>
                                                                 <td class="oxygenvalue"><xsl:value-of select="Value"/></td>
                                                                 <td class="oxygentime"><xsl:value-of select="DateTime"/> </td>
                                                                 <td class="weightsampleperformed"><xsl:value-of select="../../WeightSamplePerformed"/></td>
                                                             </tr>
                                                         </xsl:for-each>
                                                     </tbody>
                                                 </table>
                                             </div>

                                         </xsl:for-each>
                                     </div>
                                 </div>
                             </div>
                         </div>
                        </xsl:for-each>
                    </div>
                </xsl:for-each>
            </xsl:for-each>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
