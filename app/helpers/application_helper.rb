module ApplicationHelper
  def default_meta_tags
    {
      site: "プロレスヌマラス",
      title: "プロレスファンに出会いを",
      reverse: true,
      separator: '|',
      description: "プロレスを語りたいプロレスファンの方がクイズ、投稿、グループチャットを通して楽しく、そして熱く交流することができるサービスです。",
      keywords: "プロレス, プロレスファン, プロレスクイズ",
      charset: "UTF-8",
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: image_url(''),
      og: {
        site_name: "プロレスヌマラス",
        title: "プロレスファンに出会いを",
        description: "プロレスを語りたいプロレスファンの方がクイズ、投稿、グループチャットを通して楽しく、そして熱く交流することができるサービスです。",
        type: 'website',
        url: request.original_url,
        image: image_url(''),
        local: 'ja-JP',
      },
      twitter: {
        card: '',
        site: '@N7sUjYSKfiBxz47',
      }
    }
  end
end
