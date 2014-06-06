<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../utilities/master.xsl" />

<xsl:template match="data">
	<xsl:choose>
		<xsl:when test="$action = 'edit' and $title != '' and //data/password-monster/password != ''">
				<form method="post" enctype="multipart/form-data">
					<input name="MAX_FILE_SIZE" type="hidden" value="5242880" />		
					<textarea name="fields[html-content]" rows="15" cols="50"><xsl:value-of select="//data/businesses/entry[name = $title]/html-content"/></textarea>
					<input type="hidden" name="id" value="{//data/businesses/entry/@id}"/>
					<input name="action[test]" type="submit" value="Submit" />
				</form>
		</xsl:when>
		<xsl:when test="$action = 'login' and $title != ''">
			<form method="post" action="{$current-url}/?debug"  enctype="multipart/form-data">
				<fieldset>
					<input name="MAX_FILE_SIZE" type="hidden" value="5242880" />				
					<input id="passwords" name="password" type="password"/>
					<input id="submit" name="password-monster" type="submit" value="submit"/>
				</fieldset>
			</form>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="//data/businesses/entry/html-content"/>
		</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>

</xsl:stylesheet>