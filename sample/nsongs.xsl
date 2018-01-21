<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="langCode">tam</xsl:variable>
    
<xsl:template match="nsongs">
<html>
<body>
    <h2>
    <xsl:choose>
        <xsl:when test="$langCode = 'tam'">
            திரைப்படப்பாடல்கள்
        </xsl:when>
        <xsl:otherwise>
            Tamil Movie Songs
        </xsl:otherwise>
    </xsl:choose>
    </h2>
    <xsl:value-of select="movie/lang[@code=$langCode]"/>
    (<xsl:value-of select="releasedyear"/>)
  <table border="1" cellspacing="0">
    <tr>
        <xsl:choose>
            <xsl:when test="$langCode = 'tam'">
              <th>#</th>
              <th style="text-align:left">பாடல்</th>
              <th style="text-align:left">பாடலசிரியர்</th>
              <th style="text-align:left">பாடியவர்கள்</th>
              <th style="text-align:left">ராகம்</th>
              <th style="text-align:left">உணர்வு</th>
            </xsl:when>
            <xsl:otherwise>
              <th>#</th>
              <th style="text-align:left">Song</th>
              <th style="text-align:left">Lyricist</th>
              <th style="text-align:left">Singers</th>
              <th style="text-align:left">Raagam</th>
              <th style="text-align:left">Feel</th>
            </xsl:otherwise>
        </xsl:choose>
    </tr>
    <xsl:for-each select="songs/song">
    <tr>
      <td><xsl:number value="position()" format="1."/></td>
      <td><xsl:value-of select="title/lang[@code=$langCode]"/></td>
      <td><xsl:value-of select="lyricists/lyricist/lang[@code=$langCode]"/></td>
      <td><xsl:value-of select="singers/singer/lang[@code=$langCode]"/></td>
      <td><xsl:value-of select="raagam/lang[@code=$langCode]"/></td>
      <td><ul>
          <xsl:for-each select="feels/feel">
            <li><xsl:value-of select="lang[@code=$langCode]"/></li>
          </xsl:for-each>
          </ul>
      </td>
    </tr>
    </xsl:for-each>
  </table>
        <!--<xsl:value-of select="songs/song/lyrics/lang[@code=$langCode]"/>-->
            <xsl:for-each select="songs/song/lyrics/lang[@code=$langCode]/section">
                <p>
                <xsl:for-each select="line">
                    <xsl:value-of select="."/><br/>
                </xsl:for-each>
                </p>
            </xsl:for-each>
</body>
</html>
</xsl:template>

</xsl:stylesheet>