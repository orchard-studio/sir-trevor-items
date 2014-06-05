<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once(TOOLKIT.'/class.json.php');
	Class eventuploadimage extends SectionEvent{

		const ROOTELEMENT = 'uploadimage';

		public $eParamFILTERS = array(
			
		);

		public static function about(){
			return array(
				'name' => 'uploadImage',
				'author' => array(
					'name' => 'Andrew Davis',
					'website' => 'http://localhost/homestylecare',
					'email' => 'andrew.davis@thinkorchard.com'),
				'version' => 'Symphony 2.4',
				'release-date' => '2014-06-05T09:15:56+00:00',
				'trigger-condition' => 'action[uploadimage]'
			);
		}

		public static function getSource(){
			return '7';
		}

		public static function allowEditorToParse(){
			return false;
		}

		public static function documentation(){
			return '
                <h3>Success and Failure XML Examples</h3>
                <p>When saved successfully, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;uploadimage result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/uploadimage></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;uploadimage result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/uploadimage></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
    &lt;label>Name
        &lt;input name="fields[name]" type="text" />
    &lt;/label>
    &lt;label>Password
        &lt;input name="fields[password]" type="text" />
    &lt;/label>
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;label>HTML CONTENT
        &lt;textarea name="fields[html-content]" rows="15" cols="50">&lt;/textarea>
    &lt;/label>
    &lt;input name="action[uploadimage]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://localhost/homestylecare/success/" /></code></pre>';
		}

		public function load()
		{
			
			if(isset($_POST['attachment'])) return $this->__trigger();	
		}
		protected function __trigger(){
			
			
			$uploads_dir = WORKSPACE.'/uploads';
			$url = URL.'/workspace/uploads';
			
			$tmp_name = $_FILES["attachment"]["tmp_name"]['file'];
			$name = $_FILES["attachment"]["name"]['file'];
			$check = move_uploaded_file($tmp_name, "$uploads_dir/$name/");
			
			$return = array(
                    "file" => array(
                        "url" => $url."/".$name
                    )
                );
								
			echo json_encode($return);
			
		}

	}
