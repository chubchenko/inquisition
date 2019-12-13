module Inquisition
  module Outputter
    class Doc
      class TechnologyStack
        EXEPTIONS = {
          monitoring_tools: 'The exception monitoring tool is absent',
          performance_tools: 'The performance services tools is absent',
          default: 'The gems of this topic not found'
        }.freeze

        ABOUT_GEMS = {
          monitoring_tools: 'used as an exception monitoring tool',
          performance_tools: 'userd as an performance monitoring tools'
        }.freeze

        MONITORING_SERVICES = {
          gems: %w[airbrake sentry-raven bugsnag rollbar raygun4ruby],
          description: ABOUT_GEMS[:monitoring_tools],
          exception: EXEPTIONS[:monitoring_tools]
        }.freeze

        MONITORING_PERFORMANCE_SERVICES = {
          gems: %w[newrelic_rpm skylight],
          description: ABOUT_GEMS[:performance_tools],
          exception: EXEPTIONS[:performance_tools]
        }.freeze

        WORKERS_WITH_JOBS = {
          gems: %w[sidekiq resque whenever delayed_job beanstalkd bunny delayed_job_active_record
                   sneakers sucker_punch baskburner que queue_classic],
          exception: EXEPTIONS[:default]
        }.freeze

        FASTERER_ISSUE_LINKS = {
          path: 'https://github.com/JuanitoFatas/fast-ruby#',
          links: {
            rescue_vs_respond_to: 'beginrescue-vs-respond_to-for-control-flow-code',
            module_eval: 'define_method-vs-module_eval-for-defining-methods-code',
            shuffle_first_vs_sample: 'arrayshufflefirst-vs-arraysample-code',
            for_loop_vs_each: 'enumerableeach-vs-for-loop-code',
            each_with_index_vs_while: 'enumerableeach_with_index-vs-while-loop-code',
            map_flatten_vs_flat_map: 'enumerablemaparrayflatten-vs-enumerableflat_map-code',
            reverse_each_vs_reverse_each: 'enumerablereverseeach-vs-enumerablereverse_each-code',
            select_first_vs_detect: 'enumerabledetect-vs-enumerableselectfirst-code',
            select_last_vs_reverse_detect: 'enumerableselectlast-vs-enumerablereversedetect-code',
            sort_vs_sort_by: 'enumerablesort-vs-enumerablesort_by-code',
            fetch_with_argument_vs_block: 'hashfetch-with-argument-vs-hashfetch--block-code',
            keys_each_vs_each_key: 'hasheach_key-instead-of-hashkeyseach-code',
            hash_merge_bang_vs_hash_brackets: 'hashmerge-vs-hash-code',
            block_vs_symbol_to_proc: 'block-vs-symbolto_proc-code',
            proc_call_vs_yield: 'proccall-and-block-arguments-vs-yieldcode',
            gsub_vs_tr: 'stringgsub-vs-stringtr-code',
            getter_vs_attr_reader: 'attr_accessor-vs-getter-and-setter-code',
            setter_vs_attr_writer: 'attr_accessor-vs-getter-and-setter-code'
          }
        }.freeze
      end
    end
  end
end
