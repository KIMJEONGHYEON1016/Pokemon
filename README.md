- **`Project` :** PokemonApp <br>
- **`Skill & Stack` :**  <br>- **`Swift`** <br> - **`UIKit`** <br> - **`Combine`** <br> - **`SDWebImage`** <br> - **`FLAnimatedImage`** <br> - **`FirebaseFirestore`**
 <br> - **`GoogleSignIn`**  

## 전체적인 소개
토이 프로젝트인 포켓몬 앱입니다.<br>
pokeAPI를 사용해 포켓몬 게임을 제작하였습니다.<br>
**Combine**을 통해서 **MVVM** 구조로 작성하였습니다.<br>
야생의 포켓몬을 랜덤으로 조우하고 배틀을 통해 포획하는 게임입니다. <br>
배포용이 아니기에 구글 로그인 만을 지원하고 있으며, **FireStore**에 데이터를 저장하고 있습니다.  <br>

## 앱 아이콘
![appicon](https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/2fb75599-8993-4943-bcb5-09c109f61b68)

## 화면 소개 및 기능 


### 로딩

<img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/b13f82be-81bb-49c1-bdff-7986ace1baac" width="300" height="650" ><br>

- 로딩 중에 Api를 통해 포켓몬 한글 이름, 타입을 가져옵니다.

- 한번 로딩이 완료된 이후, 다시 로딩할 필요가 없습니다.

- 로딩이 완료될시 로그인 화면으로 이동합니다. 

### 로그인

<img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/ef6e900a-2bf4-4d63-81f5-3d5b176bca6a" width="300" height="650" ><br>

- 구글 로그인을 지원합니다. 해당 소셜에서 이메일 정보를 가져옵니다.

- 한 번 로그인 할 시 로그인 정보를 저장해 재로그인할 필요는 없습니다.


### 메인화면
<img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/e9e553a3-ef8e-49ad-b345-18c947c49e29" width="300" height="650" ><br>

- 파트너 포켓몬으로 지정한 포켓몬이 표시됩니다. 

- 상단에 전투력이 표기됩니다.

- 가운데 몬스터볼 버튼을 누를시 야생포켓몬과 조우합니다.

- 메뉴바 버튼을 통해 도감, 마이포켓몬으로 이동이 가능합니다.

### 전투화면
<img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/4439185c-00c2-4f2f-b4d6-e059622bb2a2" width="300" height="650" > <img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/6d75547f-e9a1-4a93-9235-1c47184d434c" width="300" height="650"> <img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/853e4306-22e3-4386-a7d3-33aa7990e2d4" width="300" height="650">

- 랜덤으로 야생포켓몬과 조우하게 되며, 전투하기 버튼을 누를 시 터치 1번당 전투력에 비례하여 실시간으로 상단 게이지 바가 변하게 됩니다. (야생 포켓몬에 전투력에 비례하여 지속적으로 감소)

- 게이지바가 100%에 달성할 시 몬스터볼 애니메이션이 실행되며 포켓몬을 포획합니다.

- 잡은 포켓몬은 마이 포켓몬에서 확인할 수 있습니다.

- 패배 시 메인화면으로 이동합니다.

### 포켓몬 도감
<img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/906c9cbf-ed84-486f-925a-723852f36eb2" width="300" height="650" >

- 모든 포켓몬의 정보를 보여줍니다. 

- 타입에 따라 배경 색상이 변경됩니다.


### 마이 포켓몬
<img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/af1ec17d-36ff-4cf5-9183-987c53ea636b" width="300" height="650" >  <img src="https://github.com/KIMJEONGHYEON1016/Pokemon/assets/127102729/0f2ae6ca-a7dd-4cd5-b0f1-b69ac1129617" width="300" height="650" >

- 잡은 포켓몬을 보여줍니다.

- 셀 안에서 포켓몬들이 랜덤으로 움직입니다.

- 포켓몬을 클릭하여 상세 정보 및 파트너 포켓몬으로 등록이 가능합니다. 


