-- AnalysingTrafficSources

select * from website_sessions;

-- This code counts unique visits from each ad type (like email or social media) for sessions with IDs between 1000 and 2000.
select 
	utm_content,
    count(distinct website_session_id) as sessions 
    from website_sessions
    where website_session_id between 1000 and 2000 -- arbitrary
    group by 
		utm_content;
        
-- This code counts unique visits and unique orders for each ad type (like email or social media) for sessions with IDs between 1000 and 2000, linking visits and orders.
select 
	website_sessions.utm_content,
    count(distinct website_sessions.website_session_id)   as Sessions,
    count( distinct orders.order_id ) as Orders
        from website_sessions 
		left join Orders
        on orders.website_session_id = website_sessions.website_session_id
    where website_sessions.website_session_id between 1000 and 2000 -- arbitrary
    group by 
		utm_content;

-- This code counts the converion rate of each sessions
select 
	website_sessions.utm_content,
    count(distinct website_sessions.website_session_id)   as Sessions,
    count( distinct orders.order_id ) as Orders,
    count( distinct orders.order_id )/ count(distinct website_sessions.website_session_id) as session_to_order_conv_rt
        from website_sessions 
		left join Orders
        on orders.website_session_id = website_sessions.website_session_id
    where website_sessions.website_session_id between 1000 and 2000 -- arbitrary
    group by 
		utm_content;

-- Assignment1: Finding Top Traffic Sources
-- Analyze website traffic sources by breaking down session volumes using UTM parameters and referring domains, focusing on data up to April 12, 2012.  
-- Ask To Do: Find session volumes by UTM source, UTM campaign, and HTTP referer for data up to April 12th, 2012 

select *
from website_sessions;

select 
	utm_campaign,
    utm_source,
    http_referer,
    count( distinct website_session_id ) as number_of_sessions 
from website_sessions		
where created_at < '2012-04-12' 
group by
	utm_campaign,
    utm_source,
    http_referer	
order by number_of_sessions desc;

-- Outcome: The results show that "gsearch nonbrand" is the most significant traffic source.    
-- ////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Assignment2: Traffic source conversion rates
-- Analyze what percentage of visits from this campaign converted into sales, and based on that conversion rate, decide whether we should adjust our bids. 

select *
from website_sessions
where created_at < '2012-04-14'
	and utm_campaign = 'nonbrand'
	and utm_source = 'gsearch';


select 
	count(distinct website_sessions.website_session_id ) as sessions,
    count(distinct orders.website_session_id ) as orders,
    count(distinct orders.website_session_id ) / count(distinct website_sessions.website_session_id ) as con_rt
from website_sessions
	left join orders
		on orders.website_session_id = website_sessions.website_session_id
where website_sessions.created_at < '2012-04-14'
		and utm_campaign = 'nonbrand'
		and utm_source = 'gsearch';		
        
-- Outcome: The analysis of the "gsearch nonbrand" campaign showed 3,895 sessions and 112 orders, leading to a conversion rate that revealed Tom was overbidding. It was recommended that he reduce spending to save the company money.    
-- ////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Assignment3- Bid optimization

select *
from website_sessions
where website_session_id between 10000 and 115000
;

select 
	website_session_id,
	month (created_at),
    week(created_at),
    year(created_at)
from website_sessions
where website_session_id between 10000 and 115000
;    

select 
    year(created_at),
    week(created_at),
    min(date (created_at)) as week_start,
	count(distinct website_session_id) as sessions
from website_sessions
where website_session_id between 10000 and 115000
group by 1,2
;    

select *
from orders
where order_id between 31000 and 32000;

select 
	order_id,
    primary_product_id,
    items_purchased
from orders
where order_id between 31000 and 32000;

select 
primary_product_id,
count(distinct case when items_purchased = 1 then order_id else null end  ) as Count_Sing_Purchase,
count(distinct case when items_purchased = 2 then order_id else null end  ) as Count_Twoice_Purchase

from orders
where  order_id between 31000 and 32000
group by 1;

-- ////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\







