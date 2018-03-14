module Aria
  class OuterIframe < SiteHelper::Iframe

    iframe(:main_if, MainIframe, :id, 'mainFrame')

  end
end