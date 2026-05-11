import Flutter
import AdPlayerLite

final class ControllerRegistry {

    // MARK: - Tags store
    private var tags: [String: AdPlayerTag] = [:]

    // MARK: - Controllers store
    private var controllers: [String: AdPlayerControllerType] = [:]

    // MARK: - Tags
    
    func addTag(_ tag: AdPlayerTag) -> String {
        let id = UUID().uuidString
        tags[id] = tag
        return id
    }

    func getTag(_ id: String) -> AdPlayerTag? {
        tags[id]
    }

    func removeTag(_ id: String) {
        tags.removeValue(forKey: id)
    }

    // MARK: - Controllers

    func addController(_ controller: AdPlayerControllerType) -> String {
        let id = UUID().uuidString
        controllers[id] = controller
        return id
    }

    func getController(_ id: String) -> AdPlayerControllerType? {
        controllers[id]
    }

    func removeController(_ id: String) {
        controllers.removeValue(forKey: id)
    }
}
