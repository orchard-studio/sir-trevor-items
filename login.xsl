<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:include href="../utilities/master.xsl" />
<xsl:template match="data">
	<xsl:choose>
		<xsl:when test="$title != ''">
			<form method="post" action="{$root}/businesses/{$title}/edit/"  enctype="multipart/form-data"> <!--{$root}/businesses/{$title}/edit -->
				<fieldset>
					<input name="MAX_FILE_SIZE" type="hidden" value="5242880" />				
					<input id="passwords" name="password" type="password"/>					
					<input id="submit" name="password-monster" type="submit" value="submit"/>
				</fieldset>
			</form>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$root}/businesses">Go Back</a>
		</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>

</xsl:stylesheet>