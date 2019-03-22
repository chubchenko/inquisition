module AuditorsHelpModule
  def auditors_tree
    {:backend=>
      {:lol_dba=>{:errors=>[], :special_info=>nil, :error_count=>0, :total_files=>0, :spended_time=>1.9176848630886525},
       :active_record_doctor=>
        {:extraneous_indexes=>
          {:errors=>
          [{:table=>"posts",
            :column=>"canbehandledbyindex_title_content",
            :message=>"can be handled by index_title_content)",
            :type=>"extraneous_indexes"}],
         :special_info=>nil,
         :error_count=>1,
         :total_files=>1,
         :spended_time=>2.295621149940416},
         :missing_foreign_keys=>
        {:errors=>[{:table=>"authors", :column=>"post_id", :message=>"none", :type=>"missing_foreign_keys"}],
         :special_info=>nil,
         :error_count=>1,
         :total_files=>1,
         :spended_time=>2.26864543906413},
         :missing_non_null_constraint=>
        {:errors=>[], :special_info=>nil, :error_count=>0, :total_files=>0, :spended_time=>1.9799162109848112},
         :missing_presence_validation=>
        {:errors=>[], :special_info=>nil, :error_count=>0, :total_files=>0, :spended_time=>2.032214693026617},
         :missing_unique_indexes=>
        {:errors=>[], :special_info=>nil, :error_count=>0, :total_files=>0, :spended_time=>1.9924959691707045},
         :undefined_table_references=>
        {:errors=>[], :special_info=>nil, :error_count=>0, :total_files=>0, :spended_time=>1.9602857248391956},
         :unindexed_deleted_at=>
        {:errors=>[], :special_info=>nil, :error_count=>0, :total_files=>0, :spended_time=>2.0245333490893245},
         :unindexed_foreign_keys=>
        {:errors=>
          [{:table=>"action_text_rich_texts", :column=>"record_id", :message=>"", :type=>"unindexed_foreign_keys"},
           {:table=>"active_storage_attachments", :column=>"record_id", :message=>"", :type=>"unindexed_foreign_keys"}],
         :special_info=>nil,
         :error_count=>2,
         :total_files=>2,
         :spended_time=>2.098656065063551}}
      }
    }
  end
end
