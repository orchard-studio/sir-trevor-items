<?php

	require_once(TOOLKIT . '/class.datasource.php');
	require_once(TOOLKIT.'/class.json.php');
	Class datasourcebusinesses extends SectionDatasource {

		public $dsParamROOTELEMENT = 'businesses';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'23' => '{$title}',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'name',
				'password',
				'merchant-id',
				'email',
				'html-content'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'businesses',
				'author' => array(
					'name' => 'Andrew Davis',
					'website' => 'http://localhost/homestylecare',
					'email' => 'andrew.davis@thinkorchard.com'),
				'version' => 'Symphony 2.4',
				'release-date' => '2014-06-04T14:34:30+00:00'
			);
		}

		public function getSource() {
			return '7';
		}

		public function allowEditorToParse() {
			return false;
		}

		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			try{
				$result = parent::execute($param_pool);
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
				return $result;
			}
			
			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			if($this->_negate_result) $result = $this->negateXMLSet();
				
				if( $result->getChildren()[1]->getName() != 'error' ){
					
					$json = $result->getChildren()[1]->getChildren()[0]->getValue();
					$json = str_replace('<![CDATA[','',$json);
					$json = str_replace(']]>','',$json);
					//$decoded = json_decode($json,true);				
					$xml = new JSON;
					$x = $xml->convertToXML($json,false);
					
					$result->getChildren()[1]->appendChild($x);
				}
			return $result;
		}
	}