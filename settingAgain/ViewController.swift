

import UIKit

struct Section{
    let title: String
    let options: [SettingsOptionType]
}
enum SettingsOptionType{
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption{
    let title: String
    let icon: UIImage?
    let iconBachgroundColor: UIColor
    let handler: (() -> Void)
    let isOn: Bool
}

struct SettingsOption{
    let title: String
    let icon: UIImage?
    let iconBachgroundColor: UIColor
    let handler: (() -> Void)
    let subtitle: String?
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)

        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        
        models.append(Section(title: "general", options: [
            .staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBachgroundColor: .systemOrange, subtitle: "sgdfasdhgfgyud"){
                print("tapped")
            }),
            .staticCell(model: SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "bluetooth"), iconBachgroundColor: .systemBlue){
                
            }),
            
        ]))
        
        models.append(Section(title: "general", options: [
            .switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBachgroundColor: .systemOrange, handler: {
            }
                , isOn: true)),
            .staticCell(model: SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "bluetooth"), iconBachgroundColor: .systemBlue){
                
            }),
            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "airplane"), iconBachgroundColor: .systemBlue){
                
            }),
            .staticCell(model: SettingsOption(title: "Mobile Data", icon: UIImage(systemName: "airplane"), iconBachgroundColor: .systemGreen){
                
            }),
            .staticCell(model: SettingsOption(title: "Personal Hotspot", icon: UIImage(systemName: "hotspot"), iconBachgroundColor: .systemGreen){
                
            })
        ]))
        
        models.append(Section(title: "imformation", options: [
            .staticCell(model: SettingsOption(title: "Notifications", icon: UIImage(systemName: "house"), iconBachgroundColor: .systemRed){
                
            }),
            .staticCell(model: SettingsOption(title: "Sounds & Haptics", icon: UIImage(systemName: "bluetooth"), iconBachgroundColor: .systemRed){
                
            }),
            .staticCell(model: SettingsOption(title: "Focus", icon: UIImage(systemName: "airplane"), iconBachgroundColor: .systemPurple){
                
            }),
            .staticCell(model: SettingsOption(title: "Screen Time", icon: UIImage(systemName: "hotspot"), iconBachgroundColor: .systemPurple){
                
            })
        ]))
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self{
        case.staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        case.switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self{
    case.staticCell(let model):
        model.handler()
    case.switchCell(let model):
        model.handler()

    }
    }
}

