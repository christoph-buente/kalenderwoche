{
  :'de' => {
    :date => {
      :formats => {
        :dmy_with_long_month    => lambda { |date| "%B #{date.day.ordinalize}, %Y" },        
      }
    },
    :time => {
      :formats => {
        :dmy_with_long_month                       => lambda { |date| "%B #{date.day.ordinalize}, %Y" },        
        :dmy_with_full_day_and_long_month_and_time => lambda { |date| "%A, %B #{date.day.ordinalize}, %Y at %H:%M" }
      }
    }
  }
}