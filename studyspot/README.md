# StudySpot — API 없는 로컬 체험판

서울 25개 자치구의 가상 장소 데이터(JSON)를 검색하고, 브라우저 LocalStorage에 즐겨찾기 및 장소 수정 사항을 저장하는 React/Vite 앱입니다. Supabase/Kakao 계정과 API 키가 필요하지 않습니다.

## 실행

```bash
npm install
npm run dev
npm run build
```

## Vercel

1. GitHub `angelgold1004/Grace-AI` 저장소 Import
2. Root Directory: `studyspot`
3. Framework: Vite, Build Command: `npm run build`, Output Directory: `dist`
4. 환경변수: **없음**
5. Deploy 후 장소 검색/즐겨찾기/관리/JSON 백업·복원 확인

## 데이터 저장

- `src/data/places.json`: 25개 자치구별 **가상** 장소 1개씩. 실제 장소·주소가 아닙니다.
- `localStorage['studyspot.local.v1']`: 각 브라우저의 장소 목록 및 즐겨찾기.
- 장소 등록/수정/삭제는 다른 사용자에게 반영되지 않습니다. 인증된 관리자 기능이 아닙니다.
- JSON 내보내기/가져오기로 수동 백업·복원이 가능합니다. 백업 파일에는 사용자가 직접 등록한 데이터가 들어 있으므로 안전하게 관리하세요.
- 브라우저 저장소 초기화·시크릿 모드·다른 기기에서는 데이터가 유지되지 않을 수 있습니다.

## 주의

- 실제 장소 검색, 회원가입, 사용자 간 데이터 동기화는 지원하지 않습니다.
- 가상 데이터는 반드시 체험 목적으로만 사용하세요.
- 기존 `api/places.js`, `supabase/schema.sql`은 과거 API 연동 버전 참고 파일로 남겨둡니다. 현재 앱에서는 사용하지 않습니다.
- 미성년자 개인정보는 수집하지 않습니다. 사용자가 장소 설명에 개인 정보를 넣지 않도록 주의하세요.
