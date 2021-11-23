class LightRequestsCountsUpdater
  def initialize(light_request = LightRequest.new)
    @light_request = light_request
  end

  def call
    LightRequest.transaction do
      update_calendar_dates_light_requests_count
      update_users_light_requests_count
    end
  end

  private

  def run_sql(statement)
    ActiveRecord::Base.connection.execute(statement)
  end

  def update_calendar_dates_light_requests_count
    run_sql update_calendar_dates_light_requests_count_sql
  end

  def update_users_light_requests_count
    run_sql update_users_light_requests_count_sql
  end

  def update_calendar_dates_light_requests_count_sql
    <<~SQL.squish
      WITH new_counts AS (
        SELECT calendar_dates.id    AS calendar_date_id
             , count(lr.*)          AS light_requests_count
          FROM calendar_dates
          LEFT OUTER JOIN light_requests lr ON lr.calendar_date_id = calendar_dates.id
         WHERE #{calendar_date_filter_sql}
         GROUP BY calendar_dates.id
       )
      UPDATE calendar_dates
         SET light_requests_count = new_counts.light_requests_count
        FROM new_counts
       WHERE calendar_dates.id = new_counts.calendar_date_id;
    SQL
  end

  def update_users_light_requests_count_sql
    <<~SQL.squish
      WITH new_counts AS (
        SELECT users.id       AS user_id
             , count(lr.*)       AS light_requests_count
          FROM users
          LEFT OUTER JOIN light_requests lr ON lr.user_id = users.id
         WHERE #{user_filter_sql}
         GROUP BY users.id
       )
      UPDATE users
         SET light_requests_count = new_counts.light_requests_count
        FROM new_counts
       WHERE users.id = new_counts.user_id;
    SQL
  end

  def calendar_date_filter_sql
    id = @light_request.calendar_date_id

    return '0 = 0' if id.nil?

    "calendar_dates.id = #{id}"
  end

  def user_filter_sql
    id = @light_request.user_id

    return '0 = 0' if id.nil?

    "users.id = #{id}"
  end
end
