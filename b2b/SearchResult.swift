

class ResultArray:Codable {
    var resultCount = 0
    var results = [SearchResult]()
}


class SearchResult:Codable {
    var idTime = ""
    var codice = ""
    var modello = ""
    var descrizione = ""
    var giacenza = ""
    var inOrdine = ""
    var prezzoAcquisto = ""
    var prezzoRiordino = ""
    var prezzoVendita = ""
    var aliquotaIva = ""
    var novita = ""
    var eliminato = ""
    var esclusiva = ""
    var barcode = ""
    var marchioCopre = ""
    var griglia = ""
    var grigliaObbligatorio = ""
    var ediel01 = ""
    var ediel02 = ""
    var ediel03 = ""
    var ediel04 = ""
    var marchio = ""
    var ricaricoPercentuale = ""
    var doppioNetto = ""
    var triploNetto = ""
    var nettoNetto = ""
    var ordinabile = ""
    var canale = ""
    var pndAC = ""
    var pndAP = ""
}
