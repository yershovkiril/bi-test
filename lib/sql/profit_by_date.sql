SELECT sum(t1.price*t1.quantity*t2.rate) as profit
          FROM sales                          as t1
          JOIN product_rates                  as t2 on t1.product_id = t2.product_id
          JOIN (
            SELECT sales.product_id,
                   sales.date as sale_date,
                   max(product_rates.date) as rate_date
              FROM sales
              JOIN product_rates on sales.product_id = product_rates.product_id
                                 and product_rates.date <= sales.date
              GROUP BY 1,2
          ) as t3 on t2.product_id = t3.product_id
                                             and t2.date = t3.rate_date
                                             and t1.date = t3.sale_date
          WHERE t1.date between %{report_start} and %{report_end}