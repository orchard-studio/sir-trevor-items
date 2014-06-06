SirTrevor.Blocks.ShopItem = (function(){
		var origin = location.origin + '/homestylecare/';
		var WORKSPACE = origin+ '/homestylecare/workspace/';
		
		
		return SirTrevor.Block.extend({
		
			type: "shop_item",
			title: 'Shop Item',
			uploadable: true,
			pastable:true,
			droppable: true,
			icon_name: 'image',			
			onBlockRender: function(){
				
				  /* Setup the upload button */
				 this.$inputs.find('button').bind('click', function(ev){ ev.preventDefault(); });
				  this.$inputs.find('input').on('change', _.bind(function(ev){
					this.onDrop(ev.currentTarget);
				  }, this));
			},	
			
			loadData: function(data){ 
			  
					  var container = $('<div class="container"></div>');
					  container.append($('<img>', { required:'required',src: data.file.url }));	  
					  var label = $('<label>Allow Mulitples : </label>');
					  var ch;
					  if(data.multiples == 'yes'){
								label.append($('<input>',{type:'checkbox',class:'st-input-boolean',name:'multiples',value:data.multiples,checked:''}));
								container.append(label);
								 container.append($('<input>', {required:'required',type: 'number', name: 'max', placeholder: 'Max Amount', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.max}));
					  }else{
								label.append($('<input>',{type:'checkbox',class:'st-input-boolean',name:'multiples',value:data.multiples}));
								container.append(label);
								 container.append($('<input>', {type: 'number', name: 'max', placeholder: 'Max Amount', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.max}));
					  }
					  container.append($('<input>', {required:'required',type: 'text', name: 'link', placeholder: '(Paste Paypal link here)', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.link}));
					  container.append($('<input>', {required:'required',type: 'text', name: 'text', placeholder: 'Price (£)', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.text}));
					  //container.append($('<input>', {type: 'number', name: 'min', placeholder: 'Min Amount', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.min}));
					  //container.append($('<input>', {type: 'number', name: 'max', placeholder: 'Max Amount', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.max}));
					  container.append($('<textarea>',{required:'required',name:'description',placeholder:'Description',style: 'width: 100%;margin-top: 10px;text-align: center;border: 1px solid #ccc;background-color: white;border-image-source: initial;border-image-slice: initial;border-image-width: initial;border-image-outset: initial;border-image-repeat: initial;-webkit-rtl-ordering: logical;-webkit-user-select: text;cursor: auto;font: -webkit-small-control;'}).text(data.description));
					  this.$editor.html(container);
					  //this.$editor.append($('<input>', {type: 'text', class: 'st-input-string js-caption-input', name: 'text', placeholder: 'Caption', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.text}));
			},			
			onContentPasted: function(event){
			  if ($(event.target).val().match(/\s/)) {
				return;
			  }

			  data = {
				file: {url:$(event.target).val()}
			  }
			  this.setAndLoadData(data);
			},	
			onDrop: function(transferData){
				console.log(transferData.files);
			  var file = transferData.files[0],
				  urlAPI = (typeof URL !== "undefined") ? URL : (typeof webkitURL !== "undefined") ? webkitURL : null;
		  
				  // Handle one upload at a time
				if (WORKSPACE+/uploads/.test(file.type)) {
					this.loading();
					// Show this image on here
					this.$inputs.hide();
					this.$editor.html($('<img>', { src: urlAPI.createObjectURL(file) })).show();
			  
					this.uploader(
					  file,
					  function(data) {
						this.loadData(data);
						this.ready();
					  },
					  function(error){
						this.addMessage(i18n.t('blocks:shopitem:upload_error'));
						this.ready();
					  }
					);
				}
			}
		});		
})();