<?php
function rechnung($rechnungsnr) {
	include_once "Rechnung.php";
	include_once("sql/sql.php");
	
	$rechnung = new Rechnung();

	$rechnung->AddPage();
	
	$rechnung->SetFont('Times', '', 8);
	$rechnung->Cell(80, 10, 'Ihre Rechnung');
	$rechnung->Ln(5);
	
	$kundenstmt = $pdo->prepare("SELECT * FROM kunde, bestellung WHERE bestellung.kundennr = kunde.kundennr AND bestellung.rechnungsnr = " . $rechnungsnr . ";");
	
	$rechnung->SetFont('Times', '', 12);
	
	if($kundenstmt->execute()) {
		$row = $kundenstmt->fetch();
		
		$rechnung->Cell(80, 10, $row['vorname'] . " " . $row['zuname']);
		$rechnung->Ln(5);
		$rechnung->Cell(80, 10, $row['plz'] . " " . $row['ort']);
		$rechnung->Ln(5);
		$rechnung->Cell(80, 10, $row['strasse']);
	}
	
	$rechnung->ln(20);
	
	$rechnung->Cell(80, 10, utf8_decode('Bestellübersicht') . " - Rechnungsnummer: " . $rechnungsnr);
	$rechnung->ln(10);
	
	$artikelstmt = $pdo->prepare("SELECT artikel.beschreibung, posten.menge, artikel.preis, posten.menge*artikel.preis as total FROM artikel, posten, bestellung WHERE bestellung.rechnungsnr = posten.rechnungsnr AND artikel.artikelnr = posten.artikelnr AND bestellung.rechnungsnr = " . $rechnungsnr . ";");
	
	$articles = array();
	$total = 0.00;
	
	if($artikelstmt->execute()) {
		while($row = $artikelstmt->fetch()){
			$a = array($row['beschreibung'], $row['menge'], $row['preis'] . " EUR", $row['total'] . " EUR");
			$total = $total + $row['total'];
			array_push($articles, $a);
		}
		
		$rechnung->PrintTable(array('Artikel', 'Anzahl', utf8_decode('Stückpreis'), 'Total'), $articles);
	}
	
	$rechnung->ln(5);
	$rechnung->Cell(80, 10, "Total: " . $total);

	$rechnung->Output();
}

rechnung(1);
?>
