import UIFoundation

struct RepositoryListSection: SectionModelType, Hashable {
    typealias Item = RepositoryListSectionItem

    let items: [RepositoryListSectionItem]
}
