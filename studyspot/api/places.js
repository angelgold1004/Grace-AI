const districts=new Set('강남구 강동구 강북구 강서구 관악구 광진구 구로구 금천구 노원구 도봉구 동대문구 동작구 마포구 서대문구 서초구 성동구 성북구 송파구 양천구 영등포구 용산구 은평구 종로구 중구 중랑구'.split(' '));
const approved=['스터디카페','독서실','도서관','카페','스터디룸'];
export default async function handler(req,res){
 if(req.method!=='GET')return res.status(405).json({error:'GET 요청만 지원합니다.'});
 const district=String(req.query.district||'강남구');const category=String(req.query.category||'스터디카페');
 if(!districts.has(district)||!approved.includes(category))return res.status(400).json({error:'유효하지 않은 검색 조건입니다.'});
 if(!process.env.KAKAO_REST_API_KEY)return res.status(503).json({error:'카카오 API 설정이 필요합니다.'});
 try{
  const params=new URLSearchParams({query:'서울 '+district+' '+category,size:'15',page:'1'});
  const response=await fetch('https://dapi.kakao.com/v2/local/search/keyword.json?'+params,{headers:{Authorization:'KakaoAK '+process.env.KAKAO_REST_API_KEY}});
  if(!response.ok)return res.status(502).json({error:'장소 제공사 조회에 실패했습니다.'});
  const data=await response.json();
  res.setHeader('Cache-Control','s-maxage=120, stale-while-revalidate=300');
  return res.status(200).json({places:(data.documents||[]).filter(p=>(p.address_name||'').startsWith('서울')&&(p.address_name||'').includes(district)).map(p=>({id:String(p.id),name:p.place_name,address:p.road_address_name||p.address_name,category:p.category_name,phone:p.phone,url:p.place_url}))});
 }catch(e){return res.status(500).json({error:'일시적으로 검색할 수 없습니다.'})}
}
