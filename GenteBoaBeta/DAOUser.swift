//
//  DAOUser.swift
//  Modulo de usuário genérico, com banco de dados Parse
//
//
//  Created by Filipo Negrao on 12/09/15.
//  Copyright (c) 2015 FilipoNegrao. All rights reserved.


import Foundation
import Parse
import ParseFacebookUtilsV4
import CoreData


class facebookContact
{
    var facebookId : String!
    
    var facebookName: String
    
    init(facebookId: String, facebookName: String)
    {
        self.facebookId = facebookId
        self.facebookName = facebookName
    }

}

enum UserCondition : String
{
    /** Notficacao responsavel por avisar quando o usaurio estiver
     logad na aplicacao */
    case userLogged = "userLogged"

    /** Notficacao responsavel por avisar ao usuario que a senha
     esta incorreta */
    case wrongPassword = "wrongPassword"

    case userNotFound = "userNotFound"

    case emailInUse = "emailInUse"

    case userLoggedOut = "userLoggedOut"

    case userAlreadyExist = "userAlreadyExist"

    /** Notificaao responsavel por informar que houve SUCESSO
     ao registrar o usuario */
    case userRegistered = "userRegistered"
    
    /** Login cancelado por algum motivo, pelo usuario ou
     pelo sistema */
    case loginCanceled = "loginCanceled"

    /** Notficacao responsavel por encaminhar o usuario para
     a tela de confirmacao de senha apos logar-se com o
     Facebook */
    case incompleteRegister = "incompleteRegister"
    
    /** Notificacao responsavel por avisar quando os contatos do usuario
     * foram carregados com sucesso */
    case contactsLoaded = "contactsLoaded"
    
    case unknowError = "unknowError"
}

private let data : DAOUser = DAOUser()

class DAOUser
{
    var user : User!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init()
    {
        if(PFUser.currentUser() != nil)
        {
            let fetch = NSFetchRequest(entityName: "User")
            let predicate = NSPredicate(format: "username == %@", PFUser.currentUser()!.email!)
            fetch.predicate = predicate
            
            do {let results = try self.managedObjectContext.executeFetchRequest(fetch) as! [User]
            
                if let result = results.first
                {
                    self.user = result
                }
            }
            catch {}
        }
    }
    
    func setInstallation()
    {
        let installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
        installation.saveInBackground()
        
    }
    
    class var sharedInstance : DAOUser
    {
        return data
    }
    
    /** Funcao que cadastra manualmente um novo
     * usuario no Parse. Possui um certo delay,
     * por nao usar callback, nao retorna nada,
     * mas apos o sucesso envia uma notifiacao
     * contida em uma das notificacoes em
     * UserCondition
     */
    func registerUser(name: String, email: String, password: String, photo: UIImage)
    {
        let data = photo.mediumQualityJPEGNSData
        let picture = PFFile(data: data)

        let user = PFUser()

        user.username = email
        user.password = password
        user.email = email

        // other fields can be set just like with PFObject
        user["profileImage"] = picture
        user["name"] = name

        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error
            {
                if(error.code == 202)
                {
                    NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.userAlreadyExist.rawValue, object: nil)
                }
                else if(error.code == 203)
                {
                    NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.emailInUse.rawValue, object: nil)
                }
                else
                {
                    NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.unknowError.rawValue, object: nil)
                }
                // Show the errorString somewhere and let the user try again.
            }
            else
            {
                NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.userRegistered.rawValue, object: nil)
                print("Usuario criado!")
                self.loginParse(email, password: password)
            }
        }
    }



    /** Funcao assincrona que executa o login com o parse;
      * A funcao nao retorna nenhuma condicao de retorno,
      * entretanto ao executar o login emite uma notificacao
      * contida em UserConditions
      */
    func loginParse(username: String, password: String)
    {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            
            
            
        }
    }

    
    
    
    /** Funcao assincrona que executa o login no Parse
      * via Facebook (Parse é do Facebook);
      * A funcao nao retorna nenhuma condicao de retorno,
      * entretanto ao executar o login emite uma notificacao
      * contida em UserConditions
      */
    func loginFaceParse()
    {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user
            {
                if user.isNew
                {
                    print("Novo usuario cadastrado pelo Facebook")
                    try! user.save()
                    self.loadFaceInfo()
                }
                else
                {
                    print("usuario logado pelo Facebook")
                    
                    let username = user.valueForKey("username") as! String
                    let name = user.valueForKey("name") as! String
                    let email = user.valueForKey("email") as! String
                    let university = user.valueForKey("university") as! String
                    let course = user.valueForKey("course") as! String
                    let period = user.valueForKey("period") as! Int
                    let about = user.valueForKey("about") as! String
                    
                    let photo = user.objectForKey("profileImage") as! PFFile
                    photo.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                        
                        if(self.user == nil)
                        {
                            let user = User.createInManagedObjectContext(self.managedObjectContext, username: username, name: name, about: about, email: email, university: university, course: course, period: period, profileImage: data)
                            
                            self.user = user
                            self.save()
                        }
                        else
                        {
                            let predicate = NSPredicate(format: "email == %@", email)
                            let fetch = NSFetchRequest(entityName: "User")
                            fetch.predicate = predicate
                            
                            do { let results = try self.managedObjectContext.executeFetchRequest(fetch) as! [User]
                                let user = results.first
                                
                                user?.username = username
                                user?.email = email
                                user?.name = name
                                user?.university = university
                                user?.course = course
                                user?.period = period
                                user?.about = about
                                user?.profileImage = data
                                
                                self.user = user
                            }
                            catch {}
                        }
                        
                        
                        self.setInstallation()
                        NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.userLogged.rawValue, object: nil)
                    })
                }
            }
            else
            {
                print("Uh oh. The user cancelled the Facebook login.")
                NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.loginCanceled.rawValue, object: nil)
            }
        }
    }

    /** Funcao que é chamada logo apos o cliente efetuar
      * o login com o parse via Facebook, busca as
      * informacoes do perfil do facebook ativo como,
      * imagem de perfil, amigos etc
      */
    func loadFaceInfo()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in

            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let name = result.valueForKey("name") as! NSString
                let email = result.valueForKey("email") as! NSString
                let username = email
                
                
                let id = result.valueForKey("id") as! String
                let pictureURL = "https://graph.facebook.com/\(id)/picture?type=large&return_ssl_resources=1"

                let URLRequest = NSURL(string: pictureURL)
                let URLRequestNeeded = NSURLRequest(URL: URLRequest!)

                NSURLConnection.sendAsynchronousRequest(URLRequestNeeded, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse? ,data: NSData?, error: NSError?) -> Void in
                    if error == nil
                    {
                        let picture = PFFile(data: data!)
                        PFUser.currentUser()?.setValue(username, forKey: "username")
                        PFUser.currentUser()?.setValue(name, forKey: "name")
                        PFUser.currentUser()?.setValue(email, forKey: "email")
                        PFUser.currentUser()!.setObject(picture!, forKey: "profileImage")
                        
                        PFUser.currentUser()!.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
                            if(success)
                            {
                                print("Registro feito, porem incompleto")
                                NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.incompleteRegister.rawValue, object: nil)
                            }
                            else
                            {
                                print(error)
                            }
                        })
                    }
                    else
                    {
                        print("Error: \(error!.localizedDescription)")
                    }
                })
            }
        })
    }

    /** Funcao que deve ser chamada logo após ser efetuado
     * o login com o parse via facebook, essa funcao completa
     * as informacoes do usuario em relacao a senha e username.
     * Funcao essencial para o andamento do sistema.
     */
    func configUserFace(university: String, course: String, period: Int, about: String)
    {
        let user = PFUser.currentUser()!
        user.setValue(university, forKey: "university")
        user.setValue(course, forKey: "course")
        user.setValue(period, forKey: "period")
        user.setValue(about, forKey: "about")
        
        user.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            
            if(success)
            {
                let email = user["email"] as! String
                let username = email
                let name = user["name"] as! String
                let file = user["profileImage"] as! PFFile
                
                file.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                    
                    let user = User.createInManagedObjectContext(self.managedObjectContext, username: username, name: name, about: about, email: email, university: university, course: course, period: period, profileImage: data)
                    self.user = user
                    self.save()
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.userLogged.rawValue, object: nil)
                    
                })
            }
            else
            {
                NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.unknowError.rawValue, object: nil)
            }
        })
    }
    
    func atualizarDados(universidade: String, curso: String, periodo: Int, sobre: String)
    {
        let user = PFUser.currentUser()!
        user.setValue(universidade, forKey: "university")
        user.setValue(curso, forKey: "course")
        user.setValue(periodo, forKey: "period")
        user.setValue(sobre, forKey: "about")
        
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if(success)
            {
                self.user.university = universidade
                self.user.course = curso
                self.user.period = periodo
                self.user.about = sobre
                self.save()
                NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.userLogged.rawValue, object: nil)

            }
            else
            {
                NSNotificationCenter.defaultCenter().postNotificationName(UserCondition.unknowError.rawValue, object: nil)
                print(error)
            }
            
            
        }
    }
    
    func getFaceContacts( callback : (metaContacts: [facebookContact]!) -> Void) -> Void {
        
        var contacts = [facebookContact]()
        var i = 0
        
        self.getFaceFriends { (friends:[facebookContact]!) -> Void in
            
            for friend in friends
            {
                let busca = PFUser.query()
                let id = friend.facebookId
                busca!.whereKey("facebookID", equalTo: id)
                busca!.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                    print(objects?.count)
                    i++
                    if let objects = objects
                    {
                        if(objects.count > 0)
                        {
                            print("Amigo \(friend.facebookName) esta no app")
                            let contact = facebookContact(facebookId: friend.facebookId, facebookName: friend.facebookName)
                            contacts.append(contact)
                        }
                    }
                    
                    if(friend.facebookId == friends.last?.facebookId)
                    {
                        print("retornando \(contacts.count) amigos")
                        callback(metaContacts: contacts)
                    }
                }
            }
            
            callback(metaContacts: contacts)
        }
    }
    
    
    /**
     * Funcao que cata os amigos no facebook
     * e retorna os mesmos em forma de metaContact
     */
    func getFaceFriends( callback : (friends: [facebookContact]!) -> Void) -> Void {

        var meta = [facebookContact]()

        let fbRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters: ["fields":"name"]);
        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
        
            if error == nil
            {
                let results = result as! NSDictionary
                let data = results.objectForKey("data") as! [NSDictionary]
                
                for(var j = 0; j < data.count; j++)
                {
                    let name = data[j].valueForKey("name") as! String
                    let id = data[j].valueForKey("id") as! String
                    let c = facebookContact(facebookId: id, facebookName: name)
                    print("Amigo \(name)")
                    meta.append(c)
                }
                callback(friends: meta)
            }
            else
            {
                print("Error Getting Friends \(error)");
                callback(friends: meta)
            }
        }
    }
    
    
    func getUsername() -> String
    {
        if(self.user != nil)
        {
            return self.user.name
        }
        else
        {
            return "Gente boa"
        }
    }

    func getEmail() -> String
    {
        if(self.user != nil)
        {
            return self.user.email
        }
        else
        {
            return "Gente boa"
        }
    }
    
    func getUniversity() -> String
    {
        if(self.user != nil)
        {
            return self.user.university
        }
        else
        {
            return "Gente boa"
        }
    }
    
    func getCourse() -> String
    {
        if(self.user != nil)
        {
            return self.user.course
        }
        else
        {
            return "Gente boa"
        }
    }
    
    func getPeriod() -> Int
    {
        if(self.user != nil)
        {
            return Int(self.user.period)
        }
        else
        {
            return 0
        }
    }
    
    func getAbout() -> String
    {
        if(self.user != nil)
        {
            return self.user.about
        }
        else
        {
            return "Gente boa"
        }
    }
    
    func isLoged() -> UserCondition
    {
        
        if(PFUser.currentUser() == nil)
        {
            return UserCondition.userLoggedOut
        }
        else
        {
            if(PFUser.currentUser()!["university"] != nil)
            {
                return UserCondition.userLogged
            }
            else
            {
                return UserCondition.incompleteRegister
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func save()
    {
        do { try self.managedObjectContext.save() }
        catch let error
        {
            print(error)
        }
    }
    
    func getProfileImage() -> UIImage?
    {
        return UIImage(data: self.user.profileImage!)

    }
    
    func getCourse() -> String?
    {
        return PFUser.currentUser()!["course"] as! String
    }
    
    func changeProfilePicture(photo: UIImage, callback: (success: Bool) -> Void)
    {
        let user = PFUser.currentUser()
        
        if(user == nil) { callback(success: false) }
        
        let file = PFFile(data: photo.mediumQualityJPEGNSData)
        
        user!["profileImage"] = file
        
        user!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if(success)
            {
                self.user.profileImage = photo.highestQualityJPEGNSData
                self.save()
                callback(success: true)
            }
            else
            {
                print("Erro ao salvar imagem: \(error)")
            }
        }
    }
    
    func logout(callback: (error: NSError?) -> Void)
    {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            
            if(error != nil)
            {
                self.user = nil
                callback(error: nil)
            }
            else
            {
                callback(error: error)
            }
        }
    }

}

