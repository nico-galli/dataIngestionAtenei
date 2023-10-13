create view ATENEI_LAUREATI AS
select COD_ATENEO, PROVINCIA, ANNO, CLASSE_VOTO_LAUREA, GENERE, NUMERO_LAUREATI
from atenei join laureati_classe_voto on COD_ATENEO = ATENEO_COD;

select UNO.PROVINCIA, NUM_ATENEI, LAU_INF100, LAU_SUP110
from 
	(select PROVINCIA, count(distinct COD_ATENEO) as NUM_ATENEI
	from ATENEI_LAUREATI
	group by PROVINCIA) as UNO,
	(select PROVINCIA, sum(NUMERO_LAUREATI) as LAU_INF100
	from ATENEI_LAUREATI
	where CLASSE_VOTO_LAUREA in ('66-90', '91-100')
    group by PROVINCIA) as DUE,
    (select PROVINCIA, sum(NUMERO_LAUREATI) as LAU_SUP110
	from ATENEI_LAUREATI
	where CLASSE_VOTO_LAUREA = '110 e lode'
    group by PROVINCIA) as TRE
where 
	UNO.PROVINCIA = DUE.PROVINCIA and 
    DUE.PROVINCIA = TRE.PROVINCIA and 
    UNO.PROVINCIA = TRE.PROVINCIA;
    