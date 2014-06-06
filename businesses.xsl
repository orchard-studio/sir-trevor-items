<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:string="http://symphony-cms.com/functions">
<xsl:include href="../utilities/master.xsl" />
<xsl:include href="../utilities/json-utilities.xsl" />
<xsl:include href="../utilities/string-utilities.xsl" />

<xsl:template match="data">	
	<xsl:choose>		
		<xsl:when test="$action = 'edit' and $title != '' and //data/password-monster/@password">
				
				<form method="post" enctype="multipart/form-data">
					<input name="MAX_FILE_SIZE" type="hidden" value="5242880" />		
					<!--<textarea name="fields[description-content]" rows="15" cols="50"><xsl:value-of select="//data/businesses/entry[name/@handle = $title]/description-content"/></textarea>-->
					<textarea name="fields[html-content]" rows="15" cols="50"><xsl:value-of select="//data/businesses/entry[name/@handle = $title]/html-content"/></textarea>
					<input type="hidden" name="id" value="{//data/businesses/entry/@id}"/>
					<input name="action[test]" type="submit" value="Submit" />
				</form>
		</xsl:when>			
		<xsl:when test="$title != ''">
			
			<div class="st-outer live">	
				<div class="st-blocks st-ready">
					<xsl:apply-templates select="//data/businesses/entry/data/data/item" mode="outer-blocks"/>
				</div>
			</div>
		</xsl:when>		
		<xsl:otherwise>		
			<ul>
				<xsl:apply-templates select="//data/businesses/entry" mode="list"/>
			</ul>
		</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>

<xsl:template match="//data/businesses/entry" mode="list">
	<li><a href="{$root}/businesses/{name/@handle}"><xsl:value-of select="name"/></a></li>
</xsl:template>

<xsl:template match="//data/businesses/entry/data/data/item" mode="outer-blocks">
<xsl:variable name="type" select="type"/>
		<div class="st-block" data-type="{type}">
						<div class="st-block__inner">
							<div class="columns-row" style="overflow:auto;">
								<div class="st-block__inner">
										<div class="{$type}">				
											<xsl:choose>					
												<xsl:when test="$type = 'video'">
													<div class="st-block__editor st-block__editor--with-sixteen-by-nine-media">
														<xsl:choose>
															<xsl:when test="data/source = 'youtube'">
																<iframe src="http://youtube.com/embed/{data/remote_id}" width="580" height="320" frameborder="0" allowfullscreen=""></iframe>
															</xsl:when>
															<xsl:when test="data/source = 'vimeo'">
																<iframe src="//player.vimeo.com/video/{data/remote_id}" width="500" height="281" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe> 
															</xsl:when>
															<xsl:otherwise></xsl:otherwise>
														</xsl:choose>
													</div>
												</xsl:when>
												<xsl:when test="$type = 'quote'">
													<blockquote class="st-required st-text-block"><xsl:value-of select="data/text"/></blockquote>
													<label class="st-input-label">Credit</label>
													<cite><xsl:value-of select="data/cite"/></cite>
												</xsl:when>
												<xsl:when test="$type = 'list'">
													<div class="st-text-block st-required">
														<xsl:variable name="listnode" select="data/text"/>
														<xsl:copy-of select="string:split($listnode,'-','ul','li')" />
													</div>
												</xsl:when>
												
												<xsl:when test="$type = 'heading'">
													<div class="st-required st-text-block st-text-block--heading"><xsl:value-of select="data/text"/></div>
												</xsl:when>									
												<xsl:when test="$type = 'image'">
													<div class="st-block-editor images">
														<img src="{data/file/url}" style="width:100%"/><label>Description:</label>
														<p><xsl:value-of select="data/description"/></p><label class="st-input-label">Price<cite><xsl:text> £</xsl:text><xsl:value-of select="data/text"/></cite>
														<xsl:if test="data/multiples = 'yes'">
															<br/>Amount : <input required="required" value="1" min="1" max="{data/max}" type="number" name="amount" id="amount" />									
														</xsl:if>
														<!--merchant id can also be the email setup in entry -->
														<script src="{$workspace}/js/paypal-button.min.js?merchant={//data/businesses/entry/merchant-id}"    data-button="buynow" data-currency="EUR"   data-name="{data/description}"    data-amount="{data/text}">
														
														</script>
														<!--<button id="paypal" data-url="{data/link}">Buy (PayPal)</button>--></label>
														
													</div>
												</xsl:when>
												
												<xsl:when test="$type = 'text'">
													<p><xsl:value-of select="data/text"/></p>
												</xsl:when>
												<xsl:when test="$type = 'columns'">
													<xsl:apply-templates select="data/columns/item" mode="convert" />						
												</xsl:when>
												<xsl:otherwise>
													<div class="st-text-block st-required">
													</div>
												</xsl:otherwise>
											</xsl:choose>			
										</div>
									</div>	
								
							</div>
						</div>
					</div>
</xsl:template>
<xsl:template match="data/columns/item" mode="convert">
		<div class="column">
			
			<xsl:choose>
				<xsl:when test="width = 3">
					<xsl:attribute name="style">width:25%;float:left;</xsl:attribute>
					<xsl:if test="blocks = ''">
							<xsl:attribute name="class">column empty</xsl:attribute>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="blocks != ''">
					<xsl:apply-templates select="blocks/item" mode="b"/>
				</xsl:when>
				<xsl:otherwise>
					<div class="st-block empty">
						<div class="st-block__inner empty">
						</div>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</div>			
</xsl:template>
	
	
<xsl:template match="blocks/item" mode="b">
	<xsl:variable name="type" select="type"/>
	
	<div class="st-block {position()}">
		<div class="st-block__inner live items">
			<div class="{$type}">				
				<xsl:choose>					
					<xsl:when test="$type = 'video'">
						<div class="st-block__editor st-block__editor--with-sixteen-by-nine-media">
							<xsl:choose>
								<xsl:when test="data/source = 'youtube'">
									<iframe src="http://youtube.com/embed/{data/remote_id}" width="580" height="320" frameborder="0" allowfullscreen=""></iframe>
								</xsl:when>
								<xsl:when test="data/source = 'vimeo'">
									<iframe src="//player.vimeo.com/video/{data/remote_id}" width="500" height="281" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe> 
								</xsl:when>
								<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
						</div>
					</xsl:when>
					<xsl:when test="$type = 'quote'">
						<blockquote class="st-required st-text-block"><xsl:value-of select="data/text"/></blockquote>
						<label class="st-input-label">Credit</label>
						<cite><xsl:value-of select="data/cite"/></cite>
					</xsl:when>
					<xsl:when test="$type = 'list'">
						<div class="st-text-block st-required">
							<xsl:variable name="listnode" select="data/text"/>
							<xsl:copy-of select="string:split($listnode,'-','ul','li')" />
						</div>
					</xsl:when>
					
					<xsl:when test="$type = 'heading'">
						<div class="st-required st-text-block st-text-block--heading"><xsl:value-of select="data/text"/></div>
					</xsl:when>									
					<xsl:when test="$type = 'image'">
						<div class="st-block-editor images">
							<img src="{data/file/url}" style="width:100%"/><label>Description:</label>
							<p><xsl:value-of select="data/description"/></p><label class="st-input-label">Price<cite><xsl:text> £</xsl:text><xsl:value-of select="data/text"/></cite>
							<xsl:if test="data/multiples = 'yes'">
								<br/>Amount : <input required="required" value="1" min="1" max="{data/max}" type="number" name="amount" id="amount" />									
							</xsl:if>
							<!--merchant id can also be the email setup in entry -->
							<script src="{$workspace}/js/paypal-button.min.js?merchant={//data/businesses/entry/merchant-id}"    data-button="buynow" data-currency="EUR"   data-name="{data/description}"    data-amount="{data/text}">
							
							</script>
							<!--<button id="paypal" data-url="{data/link}">Buy (PayPal)</button>--></label>
							
						</div>
					</xsl:when>
					
					<xsl:when test="$type = 'text'">
						<p><xsl:value-of select="data/text"/></p>
					</xsl:when>
					<xsl:otherwise>
						<div class="st-text-block st-required">
						</div>
					</xsl:otherwise>
				</xsl:choose>			
			</div>
		</div>			
	</div>
</xsl:template>
	
</xsl:stylesheet>