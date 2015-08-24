//
//  DataCenterDeal.m
//  TaoJie
//
//  Created by 超 刘 on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include "DataCenterDeal.h"
#include <sstream>
#include <iomanip>

string GetTimestr(int pubdate)
{
	tm* pubDate = localtime((const time_t*)&pubdate);
	
	tm stPubDate = *pubDate; // add by lucas 0531
	
	int yearOfPubDate = pubDate->tm_year + 1900;
	int monOfPubDate = pubDate->tm_mon + 1;
	int dayOfPubDate = pubDate->tm_mday;
	int hourOfPubDate = pubDate->tm_hour;
	int minOfPubDate = pubDate->tm_min;
	int secOfPubDate = pubDate->tm_sec;
	
	time_t now = time(0);
	
	tm* today = localtime((const time_t*)&now);
	int yearOfToday = today->tm_year + 1900;
	int dayOfToday = today->tm_mday;
	
	int times = now - pubdate;
	if (times < 0)
	{
		times = -times;
	}
	ostringstream s;
	
	
	if (times >= 0 && times < 60)
	{
		s << "刚刚";
	}
	else if (times >= 60 && times < 60 * 60)
	{
		s << times / 60 << "分钟前";
	}
	else if (times >= 60 * 60 && times < 60 * 60 * 24)
	{
		if (dayOfToday != dayOfPubDate)
		{
			s << "昨天 " << setw(2) << setfill('0') << hourOfPubDate << ":" << setw(2) << setfill('0') << minOfPubDate << ":" << setw(2) << setfill('0') << secOfPubDate;
		}
		else 
		{
			s << times / (60 * 60) << "小时前";
		}
	}
	else if (times >= 60 * 60 * 24 && times < 60 * 60 * 24 * 2)
	{
		if (dayOfToday - dayOfPubDate == 1)
		{
			s << "昨天 " << setw(2) << setfill('0') << hourOfPubDate << ":" << setw(2) << setfill('0') << minOfPubDate << ":" << setw(2) << setfill('0') << secOfPubDate;
		}
		else if (dayOfToday - dayOfPubDate > 1)
		{
			s << "前天 " << setw(2) << setfill('0') << hourOfPubDate<< ":" << setw(2) << setfill('0') << minOfPubDate << ":" << setw(2) << setfill('0') << secOfPubDate;
		}
		else 
		{
			s << yearOfPubDate << "年" << monOfPubDate << "月" << dayOfPubDate << "日";
		}
	}
	else if (times >= 60 * 60 * 24 * 2 && times < 60 * 60 * 24 * 3)
	{
		if (dayOfToday - dayOfPubDate == 2)
		{
			s << "前天 " << setw(2) << setfill('0') << hourOfPubDate<< ":" << setw(2) << setfill('0') << minOfPubDate << ":" << setw(2) << setfill('0') << secOfPubDate;
		}
		else if (dayOfToday - dayOfPubDate > 2)
		{
			if (yearOfToday != yearOfPubDate)
			{
				s << yearOfPubDate << "年" << monOfPubDate << "月" << dayOfPubDate << "日";	
			}
			else 
			{
				s << stPubDate.tm_mon + 1 << "月" << stPubDate.tm_mday << "日 " << setw(2) << setfill('0') << stPubDate.tm_hour << ":" << setw(2) << setfill('0') << stPubDate.tm_min << ":" << setw(2) << setfill('0') << secOfPubDate;
			}
		}
		else 
		{
			s << yearOfPubDate << "年" << monOfPubDate << "月" << dayOfPubDate << "日";
		}
	}
	else if (times >= 60 * 60 * 24 * 3)
	{
		if (yearOfToday != yearOfPubDate)
		{
			s << yearOfPubDate << "年" << monOfPubDate << "月" << dayOfPubDate << "日";	
		}
		else 
		{
			s << stPubDate.tm_mon + 1 << "月" << stPubDate.tm_mday << "日 " << setw(2) << setfill('0') << stPubDate.tm_hour << ":" << setw(2) << setfill('0') << stPubDate.tm_min << ":" << setw(2) << setfill('0') << secOfPubDate;
		}
	}
	
	return s.str();
}