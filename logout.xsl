<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../utilities/master.xsl" />
<xsl:template name="logout">
<p>You have successfully logged out</p>
	<a href="{$root}/businesses/">View All</a><br/>
	<a href="{$root}/login/{$title}/">Login</a>
</xsl:template>

</xsl:stylesheet>