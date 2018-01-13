<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="nsongs">
<html>
<body>
    <h2>திரைப்படப்பாடல்கள்</h2>
    <xsl:value-of select="movie/lang[@code='tam']"/>
    (<xsl:value-of select="releasedyear"/>)
  <table border="1" cellspacing="0">
    <tr>
      <th style="text-align:left">பாடல்</th>
      <th style="text-align:left">பாடலசிரியர்</th>
      <th style="text-align:left">பாடியவர்கள்</th>
      <th style="text-align:left">ராகம்</th>
      <th style="text-align:left">உணர்வு</th>
    </tr>
    <xsl:for-each select="songs/song">
    <tr>
      <td><xsl:value-of select="title/lang[@code='tam']"/></td>
      <td><xsl:value-of select="lyricists/lyricist/lang[@code='tam']"/></td>
      <td><xsl:value-of select="singers/singer/lang[@code='tam']"/></td>
      <td><xsl:value-of select="raagam/lang[@code='tam']"/></td>
      <td><ul>
          <xsl:for-each select="feels/feel">
            <li><xsl:value-of select="lang[@code='tam']"/></li>
          </xsl:for-each>
          </ul>
      </td>
    </tr>
    </xsl:for-each>
  </table>
    <span><xsl:value-of select="songs/song/lyrics/lang[@code='tam']"/></span>
</body>
</html>
</xsl:template>

</xsl:stylesheet>