select g.idGrupo 'ID Grupo', g.nome 'Nome Grupo', coalesce(hs.idSubgrupo, '') 'ID Subgrupo', coalesce(s.nome,'') 'Nome Subgrupo', s.descricao 'Descricao Subgrupo'
from grupo g
join grupo_has_subgrupo hs
on g.idGrupo = hs.idGrupo
join subgrupo s
on hs.idSubgrupo = s.idSubgrupo
order by g.idGrupo;