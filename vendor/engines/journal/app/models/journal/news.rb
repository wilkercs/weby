module Journal
  class News < ActiveRecord::Base
    include Trashable
    include OwnRepository

    weby_content_i18n :title, :summary, :text, required: :title

    STATUS_LIST = %w(draft review published)


    belongs_to :site
    belongs_to :user

    has_many :views, as: :viewable
    has_many :menu_items, as: :target, dependent: :nullify
    has_many :posts_repositories, as: :post, dependent: :destroy
    has_many :related_files, through: :posts_repositories, source: :repository
    has_many :news_sites, foreign_key: :journal_news_id, class_name: "::Journal::NewsSite", dependent: :destroy
    has_many :sites, :through => :news_sites, class_name: "::Journal::NewsSite"
    has_many :newsletter_histories, dependent: :destroy, class_name: "::Journal::NewsletterHistories"

    # Validations
    validates :user_id, :site_id, :status, presence: true

    validate :validate_date

    scope :published, -> { where(status: 'published') }
    scope :review, -> { where(status: 'review') }
    scope :draft, -> { where(status: 'draft') }
    scope :by_user, ->(id) { where(user_id: id) }

    # tipos de busca
    # 0 = "termo1 termo2"
    # 1 = termo1 AND termo2
    # 2 = termo1 OR termo2
    scope :search, ->(param, search_type) {
      if param.present?
        fields = ['journal_news_i18ns.title', 'journal_news_i18ns.summary', 'journal_news_i18ns.text',
                  'users.first_name']
        query, values = '', {}
        case search_type
        when 0
          query = fields.map { |field| "LOWER(#{field}) LIKE :param" }.join(' OR ')
          values[:param] = "%#{param.try(:downcase)}%"
        when 1, 2
          keywords = param.split(' ')
          query = fields.map do |field|
            "(#{
                keywords.each_with_index.map do |keyword, idx|
                  values["key#{idx}".to_sym] = "%#{keyword.try(:downcase)}%"
                  "LOWER(#{field}) LIKE :key#{idx}"
                end.join(search_type == 1 ? ' AND ' : ' OR ')
            })"
          end.join(' OR ')
        end
        includes(:user, :i18ns, :locales)
        .where(query, values)
        .references(:user, :i18ns)
      end
    }

#    before_trash do
#      if published?
#        errors[:base] << I18n.t('cannot_destroy_a_published_page')
#        false
#      else
#        true
#      end
#    end

    def self.import(attrs, options = {})
      return attrs.each { |attr| import attr, options } if attrs.is_a? Array
      return if attrs['site_id'] != options[:site_id]
      
      attrs = attrs.dup
      attrs = attrs['news'] if attrs.key? 'news'
      id = attrs['id']
      attrs.except!('id', '@type', 'type', 'created_at', 'updated_at', 'site_id')

      attrs['user_id'] = options[:user] unless User.unscoped.find_by(id: attrs['user_id'])
      repo_id = Import::Application::CONVAR["repository"]["#{attrs['repository_id']}"]
      repo = Repository.find(repo_id) if !repo_id.blank?
      attrs.except!('repository_id')
      if repo && repo.archive_content_type
        repo.image? ? attrs['repository_id'] = repo_id : attrs.except!('repository_id')
      end

      attrs['i18ns'] = attrs['i18ns'].map do |i18n|
        i18n['text'] = i18n['text'].gsub(/\/up\/[0-9]+/) {|x| "/up/#{options[:site_id]}"} if i18n['text']
        self::I18ns.new(i18n.except('id', '@type', 'type', 'created_at', 'updated_at', 'journal_news_id'))
      end

      attrs['related_file_ids'] = attrs.delete('related_files').to_a.map {|repo| Import::Application::CONVAR["repository"]["#{repo['id']}"] }

      news = self.create!(attrs)
      if news.persisted?
        Import::Application::CONVAR["news"]["#{id}"] ||= "#{news.id}"
      end
    end

    def to_param
      "#{id} #{title}".parameterize
    end

    def published?
      status == 'published'
    end

    def link
      if url.blank?
        news_url(self, subdomain: self.site)
      else
        url
      end
    end

    accepts_nested_attributes_for :news_sites, allow_destroy: true

    private

    def validate_date
      self.date_begin_at = Time.now.to_s if date_begin_at.blank?
    end
  end
end
