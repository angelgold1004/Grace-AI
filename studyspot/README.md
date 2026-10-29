# StudySpot — 중·고등학생 공부공간 찾기

React + Vite + Supabase Auth/Postgres + Kakao Local API + Vercel 서버리스 API.

## 개발 서버

1. `npm install`
2. `cp .env.example .env` 후 값 설정
3. Supabase SQL Editor에서 `supabase/schema.sql` 실행
4. `npm run dev` (로컬 Vite 서버는 /api 서버리스 함수를 제공하지 않음. 전체 검색 테스트는 `vercel dev` 또는 배포 URL에서 진행)
5. `npm run build` 검증

## Vercel 배포

- GitHub 저장소 **Grace-AI**, Root Directory **studyspot** 지정
- Framework: Vite, Build Command: `npm run build`, Output: `dist`
- 환경변수: `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`, `KAKAO_REST_API_KEY`
- Supabase Auth의 Site URL / Redirect URL에 실제 Vercel 도메인 등록
- 비밀 키는 Git에 업로드하지 마세요. 공개 가능한 Supabase anon/publishable key만 VITE_ 변수 사용

## 사용자 보호 / MVP 제한

- 카카오 장소 데이터는 실시간 검색 결과이며 학교명, GPS, 실명은 수집하지 않습니다.
- 만 14세 이상 확인은 **자기 선언**일 뿐 실제 연령 검증이 아닙니다. 만 14세 미만 계정 생성 차단의 확실한 검증 수단은 아니므로 실제 미성년자 공개 서비스 전 법률·개인정보 검토와 서버측 가입 정책/검증을 반드시 추가하세요.
- 회원가입 인증메일, RLS, 계정삭제 처리, 개인정보 처리방침·동의 증빙, 접근성, abuse/rate limiting, 관리자 신고 검수는 운영 전 점검이 필요합니다.
- 출시 전까지 시범용으로만 사용하세요. 원칙적으로 계정 탈퇴 요청은 운영자 수작업으로 처리해야 합니다.
- 장소 정보 정확성, 운영 시간, 청소년 출입 가능 여부를 확인하도록 안내합니다.

## 저장 구조

- Auth: 이메일 / 비밀번호 (비밀번호 DB 직접 저장 금지)
- profiles: 닉네임
- favorites: 계정별 저장 장소
- place_reports: 오류 신고
- 각 테이블은 사용자 자신의 행에만 접근 가능한 RLS 적용
