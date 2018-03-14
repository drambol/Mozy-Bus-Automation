module Aria
  class MainIframe < SiteHelper::Iframe

    iframe(:work_if, WorkIframe, :id, 'work_frm')

  end
end