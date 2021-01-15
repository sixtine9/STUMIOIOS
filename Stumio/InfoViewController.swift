
import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var aPropos: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.isNavigationBarHidden = false

        var htmlText = "Dans le contexte de pandémie actuelle, <br>Il est difficile d’imaginer que les sorties, évènements musicaux, bars, restaurants… rouvriront jour <br><br>STUMIO, se veut être une application ambitieuse, proposant à des individus de tout âge, de toutes classes sociales des endroits, des moments à <br> partager <br><br>Nous voulons réinventer les sorties, ne plus se contenter d’aller dans ce même bar, dans ce même restaurant de quartier mais élargir son carnet <br>d’adresse en en découvrant de nouveaux, <br><br>Nous voulons permettre à tous de découvrir, de rencontrer et d’aimer de nouveaux endroits <br><br><br>Nous pensons qu’il est essentiel d’anticiper et d’espérer la fin de cette pandémie, <br>En tant que futurs ingénieurs, nous devons nous projeter et penser à l’après.<br>Il s’agit peut-être aujourd’hui, pour vous, d’une démarche futuriste,<br>Nous croyons à demain, <br><br>Nous pouvons aider des restaurants, des bars à se sortir des creux financiers causé par la pandémie,<br>Tout en faisant découvrir de nouveaux lieux de partages aux gens. <br><br>STUMIO sera disponible fin décembre dans certains arrondissements de Paris<br>Et dans les règlementations sanitaires lié au contexte actuel<br><br><br></h6>Cordialement, <br>L'équipe STUMIO <br></h6>"
        
        aPropos.attributedText = htmlText.htmlToAttributedString
        
        aPropos.textColor = UIColor.white
        aPropos.textAlignment = .center
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
