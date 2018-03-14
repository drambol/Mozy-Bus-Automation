module CustomCDAPI
  class CustomCD
    CUSTOMCD_WSDL = "http://selfservice-stg.customcd.com/SelfService.PublicAPI/OrderService.asmx?wsdl"
    CUSTOMCD_API_KEY = "eWs2TePgoXBxr5czun5gdQ=="

    def initialize
      @savon_client = Savon::Client.new {
        wsdl.document = CUSTOMCD_WSDL
      }
    end

    #{:ping_result=>true}
    def ping
      (@savon_client.request :ping).to_hash[:ping_response]
    end

    #{:order_status=>"Cancelled", :is_success=>true, :order_id=>"338258"}
    def get_order_status(order_id)
      result = (@savon_client.request :get_order_status_ex, "xmlns:wsdl" => "http://www.customcd.us/selfservice/publicApi" do
        soap.body = {
            :developer_id => CUSTOMCD_API_KEY,
            :order_id => order_id
        }
      end)
      result = result.to_hash[:get_order_status_ex_response][:get_order_status_ex_result]
      if result[:is_success]
        result
      else
        raise CustomCDOrderStatusException, result[:message]
      end
    end

    #{:order_status=>"Cancelled", :order_id=>"22852", :is_status_retrieved_succesfuly=>true}
    def cancel_order(order_id)
      result = (@savon_client.request :cancel_order, "xmlns:wsdl" => "http://www.customcd.us/selfservice/publicApi" do
        soap.body = {
            :developer_id => CUSTOMCD_API_KEY,
            :order_id => order_id
        }
      end)
      result = result.to_hash[:cancel_order_response][:cancel_order_result]
      if result[:is_status_retrieved_succesfuly]
        result
      else
        raise CustomCDCancelOrderException, result[:error_message]
      end

    end
  end
end
class CustomCDOrderStatusException < Exception
end
class CustomCDCancelOrderException < Exception
end

