<?php
class SQL extends PDO {
	
	private $engine;
	private $host;
	private $database;
	private $user;
	private $pass;
	
	public function __construct() {
		$this->engine = 'mysql';
		$this->host = 'localhost';
		$this->database = 'Rechnung_Arbeit';
		$this->user = 'root';
		$this->pass = '';
		
		$dns = $this->engine.':dbname='.$this->database.';host='.$this->host;
		parent::__construct($dns, $this->user, $this->pass);
	}
	
}

$dsn = sprintf( 'mysql:dbname=%s;host=%s', 'Rechnung_Arbeit', 'localhost');
$pdo = new PDO($dsn, 'root', '');
?>
