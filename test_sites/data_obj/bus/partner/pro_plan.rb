# encoding: utf-8
module Bus
  module DataObj
    # This class contains attributes for data shuttle order
    class ProPlan
      attr_accessor :name, :company_type, :root_role, :description, :enabled, :public, :currency, :tax_percentage, :tax_name, :auto_include_tax, :server, :desktop, :grandfathered, :generic, :periods
      def initialize(hash)
        default_plan = {name: "$AUTOTEST$ #{Forgery(:basic).password(:at_least => 4, :at_most => 6)} Pro Plan", company_type:'business', description:'', enabled:'Yes', public:'No', currency:"$ — US Dollar (Partner Default)", periods:'yearly', tax_percentage:1, tax_name:'test', auto_include_tax:'no'}
        plan = default_plan.merge(hash)
        plan.each do |k, v|
          self.instance_variable_set("@#{k}", v)
        end
      end
    end
  end
end
