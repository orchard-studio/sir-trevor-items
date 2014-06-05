(function ($){
	var origin = location.origin + '/homestylecare/';
	var WORKSPACE = origin+ '/homestylecare/workspace/';
	SirTrevor.Blocks.Image = SirTrevor.Block.extend({

		type: "image",
		title: function() { return 'Shop Item' },

		droppable: true,
		uploadable: true,

		icon_name: 'ShopItem',

		loadData: function(data){ // loads the data 'image into the div until save'
		  
		  var container = $('<div class="container"></div>');
		  container.append($('<img>', { required:'required',src: data.file.url }));	  
		  container.append($('<input>', {required:'required',type: 'text', name: 'link', placeholder: '(Paste Paypal link here)', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.link}));
		  container.append($('<input>', {required:'required',type: 'text', name: 'text', placeholder: 'Price (£)', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.text}));
		  container.append($('<textarea>',{required:'required',name:'description',placeholder:'Description',style: 'width: 100%;margin-top: 10px;text-align: center;border: 1px solid #ccc;background-color: white;border-image-source: initial;border-image-slice: initial;border-image-width: initial;border-image-outset: initial;border-image-repeat: initial;-webkit-rtl-ordering: logical;-webkit-user-select: text;cursor: auto;font: -webkit-small-control;'}).text(data.description));
		  this.$editor.html(container).show();
		  //this.$editor.append($('<input>', {type: 'text', class: 'st-input-string js-caption-input', name: 'text', placeholder: 'Caption', style: 'width: 100%; margin-top:10px; text-align: center;', value: data.text}));
		},
		
		onBlockRender: function(){
		  /* Setup the upload button */
		  this.$inputs.find('button').bind('click', function(ev){ ev.preventDefault(); });
		  this.$inputs.find('input').on('change', _.bind(function(ev){ // hidden input
		    this.onDrop(ev.currentTarget); // links to function further down
		  }, this));
		},
		onContentPasted: function(event){
		  this.handleDropPaste($(event.target).val());
		},

		handleDropPaste: function(url){
		  if(!_.isURI(url)) {
			return;
		  }

		  var match, data;

		  _.each(this.providers, function(provider, index) {
			match = provider.regex.exec(url);

			if(match !== null && !_.isUndefined(match[1])) {
			  data = {
				source: index,
				remote_id: match[1]
			  };

			  this.setAndLoadData(data);
			}
		  }, this);
		},

		onDrop: function(transferData){
		  var file = transferData.files[0],
		      urlAPI = (typeof URL !== "undefined") ? URL : (typeof webkitURL !== "undefined") ? webkitURL : null;

		  // Handle one upload at a time
		  if (WORKSPACE+/uploads/.test(file.type)) {
		    this.loading();
		    // Show this image on here
		    this.$inputs.hide();
		    this.loadData({file: {url: urlAPI.createObjectURL(file)}});

		    this.uploader(
		      file,
		      function(data) {
		        this.setData(data);
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
}(jQuery));