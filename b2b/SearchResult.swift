

class ResultArray:Codable {
    var resultCount = 0
    var results = [SearchResult]()
}

class SearchResult:Codable {
    var idTime = ""
    var codice = ""
    var modello = ""
    var descrizione = ""
    var giacenza = 0
    var inOrdine = 0
    var prezzoAcquisto = 0.0
    var prezzoRiordino = 0.0
    var prezzoVendita = 0.0
    var aliquotaIva = 0.0
    var novita = false
    var eliminato = false
    var esclusiva = false
    var barcode = ""
    var marchioCopre = ""
    var griglia = ""
    var grigliaObbligatorio = ""
    var ediel01 = ""
    var ediel02 = ""
    var ediel03 = ""
    var ediel04 = ""
    var marchio = ""
    var ricaricoPercentuale = 0.0
    var doppioNetto = 0.0
    var triploNetto = 0.0
    var nettoNetto = 0.0
    var ordinabile = false
    var canale = 0
    var pndAC = 0.0
    var pndAP = 0.0
}
