class SearchChatGroupsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
      
  attribute :group_name_or_group_description, :string
      
  def search
    scope = ChatGroup.distinct
    scope = scope.group_name_contain(group_name_or_group_description).or(scope.group_description_contain(group_name_or_group_description)) if group_name_or_group_description.present?
    scope
  end
end