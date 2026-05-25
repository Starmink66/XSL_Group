<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:key name="ixCity" match="item" use="@city"/>
    <xsl:key name="ixCityOrg" match="item" use="concat(@city, '|', @org)"/>
    
    <xsl:template match="orgs">
        <html>
            <body>
                <xsl:for-each select="item[generate-id()=generate-id(key('ixCity', @city))]">
                    <xsl:variable name="city" select="@city"/>
                    
                    <h3>Город: <xsl:value-of select="$city"/></h3>
                    <h4>Всего организаций: <xsl:value-of select="count(key('ixCity', $city))"/></h4>
                    <xsl:for-each select="key('ixCity', $city)[generate-id() = generate-id(key('ixCityOrg', concat($city, '|', @org)))]">
                        <xsl:variable name="org" select="@org"/>
                        
                        <h4><xsl:value-of select="$org"/></h4>
                        <h4>Всего товаров:<xsl:value-of select="count(key('ixCityOrg', concat($city, '|', $org)))"/></h4>
                        
                        <ul>
                            <xsl:for-each select="key('ixCityOrg', concat($city, '|', $org))">
                                <li><xsl:value-of select="@title"/></li>
                            </xsl:for-each>
                        </ul>
                    </xsl:for-each>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
