World_map<-st_read(here::here("World_Countries_(Generalized)_9029012925078512962.geojson"))
Index2 <- read_csv(here::here("inequality indexUTF8.csv"))

library(countrycode)
clean_names(Index)


World_map2<-World_map %>%
  mutate(isoname=countrycode::countrycode(World_map[[2]], origin="country.name", destination = 'iso.name.en') )
Index_renamed<-Index2 %>%
  mutate(isoname=countrycode::countrycode(Index2[[2]], origin="country.name", destination = 'iso.name.en') )
#同步标准名称

World_Index<-World_map2 %>%
  left_join(Index_renamed, by = "isoname") %>%
  distinct()
  #merge(World_map2,Index_renamed, by=intersect('isoname','isoname'))
  #自带的merge这玩意不支持空间数据的合并，用dplyr好些
#合并表单，删除重复行（因为是左合并，所以要删除一下）

tmap_mode("plot")
qtm(World_Index, 
    fill = "Gender Inequality Index", alpha=0.8,
    colorNA= 'white'
    )
#画图


?tmap

?codelist
names(World_Index)