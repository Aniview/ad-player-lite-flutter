import Flutter
import AdPlayerLite

final class ControllerRegistry {

    // MARK: - TAGS
    private var tags: [String: AdPlayerTag] = [:]

    // MARK: - CONTROLLERS
    private var controllers: [String: AdPlayerInReadController] = [:]

    // MARK: - TAGS

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

    // MARK: - CONTROLLERS

    func addController(_ controller: AdPlayerInReadController) -> String {
        let id = UUID().uuidString
        controllers[id] = controller
        return id
    }

    func getController(_ id: String) -> AdPlayerInReadController? {
        controllers[id]
    }

    func removeController(_ id: String) {
        controllers.removeValue(forKey: id)
    }
}
