<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html>
        <head>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" />
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" />
            <link rel="stylesheet" href="ewos.css" />
        </head>
        <body>
            <xsl:for-each select="Export">
                <div class="export">
                <div class="export_source"><xsl:value-of select="ExportSource"/></div>
                <div class="export_destination"><xsl:value-of select="ExportDestination"/></div>
                <div class="export_version"><xsl:value-of select="ExportVersion"/></div>
                <div class="export_date_time"><xsl:value-of select="ExportDateTime"/></div>
                <div class="start_date"><xsl:value-of select="StartDate"/></div>
                <div class="end_date"><xsl:value-of select="EndDate"/></div>
                </div>
                <xsl:for-each select="Companies/Company">
                    <div class="company">
                    <div class="company_name"><xsl:value-of select="CompanyName"/></div>
                    <div class="organization_number"><xsl:value-of select="OrganizationNumber"/></div>
                    </div>
                        <xsl:for-each select="Sites/Site">
                          <div class="site">
                            <div class="site_name"><xsl:value-of select="SiteName"/></div>
                            <div class="site_number"><xsl:value-of select="SiteNumber"/></div>
                            <div class="site_id"><xsl:value-of select="SiteID"/></div>
                            <div class="max_allowed_biomass"><xsl:value-of select="MaxAllowedBiomass"/></div>
                            <div class="last_date_of_registration"><xsl:value-of select="LastDateOfRegistration"/></div>
                            <div class="latitude"><xsl:value-of select="Latitude"/></div>
                            <div class="longitude"><xsl:value-of select="Longitude"/></div>
                          </div>
                            <!-- Quality Samples  : -->
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
                                    <th>Sample date</th>
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
                                        <td class="sample_date"><xsl:value-of select="SampleDate"/></td>
                                        <td class="condition_factor"><xsl:value-of select="ConditionFactor"/></td>
                                        <td class="total_length"><xsl:value-of select="TotalLength"/></td>
                                        <td class="weight_gutted"><xsl:value-of select="WeightGutted"/></td>
                                    </tr>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                            </tbody>
                            </table>
                            <!-- Groups and periods : -->
                              <xsl:for-each select="Groups/Group">
                                  <div class="group">
                                <div class="unit_name"><xsl:value-of select="UnitName"/></div>
                                <div class="unit_volume"><xsl:value-of select="UnitVolume"/></div>
                                <div class="group_id"><xsl:value-of select="GroupID"/></div>
                                <div class="group_name"><xsl:value-of select="GroupName"/></div>
                                <div class="first_date_of_input"><xsl:value-of select="FirstDateOfInput"/></div>
                                <div class="last_date_of_input"><xsl:value-of select="LastDateOfInput"/></div>
                                <div class="species_id"><xsl:value-of select="Species/SpeciesID"/></div>
                                <div class="species_name"><xsl:value-of select="Species/SpeciesName"/></div>
                                <div class="fishtypes">
                                <xsl:for-each select="FishTypes/FishType">
                                    <div class="fishtype_code"><xsl:value-of select="Code"/></div>
                                    <div class="fishtype_textual"><xsl:value-of select="Textual"/></div>
                                </xsl:for-each>
                                </div>
                                <div class="strains">
                                    <xsl:for-each select="Strains">
                                        <div class="strain"><xsl:value-of select="Strain"/></div>
                                    </xsl:for-each>
                                </div>
                                  </div>

                                <table class="periods">
                                    <thead>
                                        <tr>
                                            <th class="first_day">Period start</th>
                                            <th class="last_day">Period end</th>
                                            <th class="end_stock_count">End stock count</th>
                                            <th class="end_stock_biomass">End stock biomass</th>
                                            <th class="stocked_count">Stocked count</th>
                                            <th class="stocked_biomass">Stocked biomass</th>
                                            <th class="movedout_count">Moved out count</th>
                                            <th class="movedout_biomass">Moved out biomass</th>
                                            <th class="movedin_count">Moved in count</th>
                                            <th class="movedin_biomass">Moved in biomass</th>
                                            <th class="loss_count">Loss count</th>
                                            <th class="loss_biomass">Loss biomass</th>
                                            <th class="sold_count">Sold count</th>
                                            <th class="sold_biomass">Sold biomass</th>
                                            <th class="average_temperature">Average temp.</th>
                                            <th class="oxygen_readings">Oxygen</th>
                                            <th class="weight_sample_performed">Weight sample</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                <xsl:for-each select="Periods/Period">
                                  <tr>
                                    <td class="first_day"><xsl:value-of select="FirstDay"/></td>
                                    <td class="last_day"><xsl:value-of select="LastDay"/></td>
                                    <td class="end_stock_count"><xsl:value-of select="EndStock/IndividCount"/></td>
                                    <td class="end_stock_biomass"><xsl:value-of select="EndStock/Biomass"/></td>
                                      <td class="stocked_count"><xsl:value-of select="Stocked/IndividCount"/></td>
                                      <td class="stocked_biomass"><xsl:value-of select="Stocked/Biomass"/></td>
                                      <td class="movedout_count"><xsl:value-of select="MovedOut/IndividCount"/></td>
                                      <td class="movedout_biomass"><xsl:value-of select="MoveOut/Biomass"/></td>
                                      <td class="movedin_count"><xsl:value-of select="MovedIn/IndividCount"/></td>
                                      <td class="movedin_biomass"><xsl:value-of select="MovedIn/Biomass"/></td>
                                      <td class="loss_count"><xsl:value-of select="Loss/IndividCount"/></td>
                                      <td class="loss_biomass"><xsl:value-of select="Loss/Biomass"/></td>
                                      <td class="sold_count"><xsl:value-of select="Sold/IndividCount"/></td>
                                      <td class="sold_biomass"><xsl:value-of select="Sold/Biomass"/></td>
                                      <td class="average_temperature"><xsl:value-of select="AverageTemperature"/></td>
                                      <td class="oxygen_readings">
                                          <span class="oxygen_reading_date_time"><xsl:value-of select="OxygenReading/DateTime"/></span>
                                          <span class="oxygen_reading_value"><xsl:value-of select="OxygenReading/Value"/></span>
                                      </td>
                                      <td class="weight_sample_performed"><xsl:value-of select="WeightSamplePerformed"/></td>
                                  </tr>
                                </xsl:for-each>
                                    </tbody>
                                </table>
                            </xsl:for-each>
                        </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
