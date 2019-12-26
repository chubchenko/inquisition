module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          class BottlenecksDetection
            class Fasterer
              class Wrapper < SimpleDelegator
                PATH = 'https://github.com/JuanitoFatas/fast-ruby#'.freeze

                EXPLENATIONS = {
                  rescue_vs_respond_to: {
                    link: (PATH + 'beginrescue-vs-respond_to-for-control-flow-code').freeze,
                    title: 'begin...rescue vs respond_to?'
                  },
                  module_eval: {
                    link: (PATH + 'define_method-vs-module_eval-for-defining-methods-code').freeze,
                    title: 'define_method vs module_eval'
                  },
                  shuffle_first_vs_sample: {
                    link: (PATH + 'arrayshufflefirst-vs-arraysample-code').freeze,
                    title: 'Array#shuffle.first vs Array#sample'
                  },
                  for_loop_vs_each: {
                    link: (PATH + 'enumerableeach-vs-for-loop-code').freeze,
                    title: 'Enumerable#each vs for'
                  },
                  each_with_index_vs_while: {
                    link: (PATH + 'enumerableeach_with_index-vs-while-loop-code').freeze,
                    title: 'Enumerable#each_with_index vs while'
                  },
                  map_flatten_vs_flat_map: {
                    link: (PATH + 'enumerablemaparrayflatten-vs-enumerableflat_map-code').freeze,
                    title: 'Enumerable#map...Array#flatten vs Enumerable#flat_map'
                  },
                  reverse_each_vs_reverse_each: {
                    link: (PATH + 'enumerablereverseeach-vs-enumerablereverse_each-code').freeze,
                    title: 'Enumerable#reverse.each vs Enumerable#reverse_each'
                  },
                  select_first_vs_detect: {
                    link: (PATH + 'enumerabledetect-vs-enumerableselectfirst-code').freeze,
                    title: 'Enumerable#detect vs Enumerable#select.first'
                  },
                  select_last_vs_reverse_detect: {
                    link: (PATH + 'enumerableselectlast-vs-enumerablereversedetect-code').freeze,
                    title: 'Enumerable#select.last vs Enumerable#reverse.detect'
                  },
                  sort_vs_sort_by: {
                    link: (PATH + 'enumerablesort-vs-enumerablesort_by-code').freeze,
                    title: 'Enumerable#sort vs Enumerable#sort_by'
                  },
                  fetch_with_argument_vs_block: {
                    link: (PATH + 'hashfetch-with-argument-vs-hashfetch--block-code').freeze,
                    title: 'Hash#fetch with argument vs Hash#fetch'
                  },
                  keys_each_vs_each_key: {
                    link: (PATH + 'hasheach_key-instead-of-hashkeyseach-code').freeze,
                    title: 'Hash#each_key instead of Hash#keys.each'
                  },
                  hash_merge_bang_vs_hash_brackets: {
                    link: (PATH + 'hashmerge-vs-hash-code').freeze,
                    title: 'Hash#merge! vs Hash#[]='
                  },
                  block_vs_symbol_to_proc: {
                    link: (PATH + 'block-vs-symbolto_proc-code').freeze,
                    title: 'Symbol#to_proc'
                  },
                  proc_call_vs_yield: {
                    link: (PATH + 'proccall-and-block-arguments-vs-yieldcode').freeze,
                    title: 'Proc#call vs yield'
                  },
                  gsub_vs_tr: {
                    link: (PATH + 'stringgsub-vs-stringtr-code').freeze,
                    title: 'String#gsub vs String#tr'
                  },
                  getter_vs_attr_reader: {
                    link: (PATH + 'attr_accessor-vs-getter-and-setter-code').freeze,
                    title: 'attr_accessor vs getter and setter'
                  },
                  setter_vs_attr_writer: {
                    link: (PATH + 'attr_accessor-vs-getter-and-setter-code').freeze,
                    title: 'attr_accessor vs getter and setter'
                  }
                }.freeze

                def group
                  group_by(&:context).each do |warning, issues|
                    yield(EXPLENATIONS.fetch(warning), issues.count)
                  end
                end
              end

              def self.call(issues)
                new(
                  Wrapper.new(Collector.new(issues, ::Inquisition::Fasterer::Runner).call)
                )
              end

              attr_reader :collection

              def initialize(collection)
                @collection = collection
              end

              def produce
                binding
              end
            end
          end
        end
      end
    end
  end
end
