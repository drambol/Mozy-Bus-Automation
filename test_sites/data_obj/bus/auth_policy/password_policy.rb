module Bus
  module DataObj
    class PasswordPolicy
      attr_accessor :user_policy_type, :admin_policy_type, :user_policy_min_length, :admin_policy_min_length, :user_min_character_classes,
                    :admin_min_character_classes, :user_character_classes, :admin_character_classes, :admin_user_same_policy,
                    :user_max_failure_per_username, :user_failure_period_per_username, :user_lockout_duration_per_username
    end
  end
end