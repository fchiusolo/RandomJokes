import Foundation
import Contacts

struct ContactsRepository {
}

extension ContactsRepository: ContactsRepositoryProtocol {
	func getContacts(_ handler: @escaping Self.ContactsResponseHandler) {
		CNContactStore().requestAccess(for: .contacts) { access, error in
			guard access else {
				handler(.failure(ContactsError.accessDenied))
				return
			}
			self.fetchAllContacts(then: handler)
		}
	}

	private func fetchAllContacts(then handler: @escaping Self.ContactsResponseHandler) {
		let contactStore = CNContactStore()
		let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)] as [CNKeyDescriptor]

		var allContainers: [CNContainer] = []
		do {
			allContainers = try contactStore.containers(matching: nil)
		} catch {
			handler(.failure(ContactsError.unknown))
			return
		}

		var results: [CNContact] = []

		for container in allContainers {
			let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
			do {
				let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate,
																		keysToFetch: keysToFetch)
				results.append(contentsOf: containerResults)
			} catch {
				handler(.failure(ContactsError.unknown))
				return
			}
		}

		results
			.randomElement()
			.map { Contact(firstName: $0.givenName, lastName: $0.familyName) }
			.map { handler(.success($0)) }
	}
}
