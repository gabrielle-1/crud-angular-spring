### Criando um projeto no Angular

```jsx
ng new [project-name]
```

*ng new crud-angular*

Utilização de roteamento: Y

Pasta **node_modules**: dependências

**tsconfig.json**: configurações typescript do projeto

assets: imagens apenas

### Executar o projeto Angular

```jsx
ng serve
```

Arquivos principais → **app.component.ts e app.module.ts**

### Instalando o Angular Material

[https://material.angular.io/guide/getting-started](https://material.angular.io/guide/getting-started)

1. Através do npm install : package.json
2. Através do ng add: `ng add @angular/material`

### Inserindo elementos do Angular Material

1. Importa:****
    1. No arquivo app.module.ts:
        1. `import {MatToolbarModule} from '@angular/material/toolbar';`
            
            ```
            imports: [
                MatToolbarModule
            ],
            ```
            
2. Agora o elemento está acessível para ser utilizado no app.component.html
    
    ```
    <mat-toolbar color="primary">
    ```
    

Ou seja, importamos o módulo no **imports** e o Angular faz a exportação dele para ser utilizado no app.component.html

## Módulos:

- Organizar de forma **lógica** a aplicação.
- Componentes criados dentro do módulo possui visibilidade protegida.
- Caso queira utilizar o componente em outro módulo, é necessário exportar o componente.

### **Criando o Módulo com roteamento**

```jsx
ng g m [name] --routing
```

### **Criando o Componente dentro do módulo**

```jsx
ng g c [name-module]/[name-component] 
```

*Foram criados os arquivos de teste, de estilo, html e o componente.*

## Rotas

Módulo de rotas global: **app-routing.module.ts**

Se o caminho estiver vazio, ou seja, apenas o **[localhost:4200](http://localhost:4200)** faça um redirecionamento para uma rota específica:

```tsx
const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'courses'}
];
```

- No arquivo de rotas do componente, criamos uma rota para ele:
    1. Especificar o caminho, abaixo colocamos o / (em branco) 
    2. Especificar o componente

```tsx
const routes: Routes = [
  { path: '', component: NameComponent}
];
```

Diretiva Angular Material para fazer o roteamento, deve-se inserir no app.component.html: 

```
<router-outlet></router-outlet>
```

No arquivo de rotas global:

Se o caminho for vazio(localhost:4200), redireciona para uma rota inicial definida anteriormente.

Vamos utilizar a rota de Lazyng-loading(carregamento lento)

- ****Lazy-loading feature module****

Para carregar módulos Angular de forma lenta, use `loadChildren`(em vez de `component`) em sua `AppRoutingModule` `routes`configuração da seguinte maneira.

<aside>
💡 loadChildren: Carregue de forma automática, já que este é um módulo filho da aplicação.

</aside>

**AppRoutingModule.ts (trecho)**

const routes:

[Routes](https://angular.io/api/router/Routes) = [
  {
    path: 'items',
    loadChildren: () => import('./items/items.module').then(m => m.ItemsModule)
  }
];

Ou seja, o que fizemos em cima foi :

Caso esteja acessando a rota “localhost:4200/items” sem nada após a barra, redirecione para o NameComponent lá em cima ^ 

**Resumindo…**

Apenas ao acessar “localhost:8080/items” que será carregado todo o módulo de items. Por padrão não é carregado no Angular.

### **Criando uma interface**

Classe para ajudar em tempo de desenvolvimento, onde podemos verificar os dados sobre o elemento a ser utilizado

```jsx
ng g interface [name]
```

### Configurando as cores do Angular Material para as cores do projeto:

- Material Design: [https://material.io/design/color/the-color-system.html#color-theme-creation](https://material.io/design/color/the-color-system.html#color-theme-creation)

**Arquivo: style.css**

1. importa o theming do angular material:
    
    ```
    @import "@angular/material/theming";
    ```
    
2. inclui o mat-core(): mixing do angular material
3. Define nossas variáveis, geralmente são 3 cores: 
    1. Primária, Secundária e de Warning(erro/aviso, padrão vermelho).
    2. Primária: 
        
        ```
        $custom-app-primary: mat-pallete($mat-purple);
        ```
        
    3. Secundária
        
        ```scss
        $custom-app-secondary: mat-palette($mat-deep-purple, A200, A400, 700);
        ```
        
    4. Erro:
        
        ```scss
        $custom-app-warning: mat-palette($mat-red);
        ```
        
4. Criação do nosso novo tema:
    
    ```
    $custom-theme: mat-light-theme($custom-app-primary, $custom-app-secondary, $custom-app-warning);
    ```
    
5. Sinalizar ao Angular o tema criado:
    
    ```
    @include angular-material-theme($custom-theme);
    ```
    

### **Criando Material Table para Listar elementos:**

1. No módulo do componente(items.module.ts), importa o mat-table:
    
    ```
    import { MatTableModule } from '@angular/material/table';
    ```
    
    ```
    imports: [
        CommonModule,
        CoursesRoutingModule,
        MatTableModule
      ]
    ```
    

O mat-table utiliza um **dataSource**:

`dataSource = ELEMENT_DATA;`

ELEMENT_DATA é um array de elementos:

```
const ELEMENT_DATA: PeriodicElement[] = [
  {position: 1, name: 'Hydrogen', weight: 1.0079, symbol: 'H'}
];
```

1. Cria o dataSource.
    1. no items.component.ts, criamos o dataSource que, inicialmente será do tipo any(qualquer coisa)
        
        ```
        courses: any[] = [];
        ```
        
    2. Criaremos um tipo(interface) para não utilizar o any(má prática). 
        1. Interface só existe em tempo de desenvolvimento.
        2. Comando: ng g interface items/model/item
            
            ```
            export interface Item {
              _id: string;
              name: string;
              category: string
            }
            ```
            
        

### *Estudar table do angular*

### Módulo shared

> Para que o componente do item não fique muito grande por conta da quantidade de imports, criamos um modulo chamado app-material dentro de uma pasta chamada shared e lá inserimos todos os imports e exportamos os módulos para serem utilizados depois na classe items.
> 

> Basta importar o shared/app-material no módulo de items.
> 

### Classe Serviço

- Fornece: Dados + Lógica de Negócios do módulo.
- Dados e manipulação dos dados para ser enviado para o componente.

Comando para criar um serviço no Angular cli:

**ng g s [nome-modulo]/[services]/[name-service]**

Serão gerados a classe de serviço e a de teste.

Na classe items.component.ts temos o decorator: **@Component** e o decorator implements **OnInit**:

@Component: Indica que é um **componente**.

OnInit: Faz parte do ciclo de vida de um componente no Angular.

Dentro do decorator **@Component** temos as seguintes propriedades:

- **selector**: ‘app-items’ → Nome do Componente/diretiva, ou seja, tag do HTML que utilizamos caso vá exportar o componente.

*Da mesma forma que acontece com os componentes do Angular Material.*

- **templateUrl**: ‘./items.component.html’ → Endereço do arquivo que contém o HTML para o componente.

- **styleUrls**: [’./items.component.scss’] → Referência para o arquivo de css

Já na classe items.service.ts temos o decorator **@Injectable**: Faz a injeção de dependência das classes dentro do Angular.

<aside>
⚠️ A classe items.component.ts **NÃO** sabe quais são os dados que serão renderizados, a responsabilidade disso é do **Serviço**.

</aside>

o **Componente** só precisa saber que vai renderizar uma **lista** de algo, por exemplo.

De onde estão vindo os dados da lista é **irrelevante** para o componente.

Pode vir de uma API ou de um arquivo json local, dados na memória e etc.

- A classe se **Serviço** manipula os dados para que fique da forma que o **Componente** está esperando.
    - Exemplo:
        
        ```
        export class CoursesComponent implements OnInit {
        
          courses: Course[] = [
            {_id: "1", name: "Angular", category: "front-end"}
          ];
        ```
        
        Então o Serviço deve renderizar esses elementos da mesma forma que antes o componente renderizava.
        
        Criamos um método para retornar uma lista de cursos, inicialmente com um curso para testes, chamamos o método de list:
        
        ```tsx
        list(): Course[]{
            return [
              {_id: "1", name: "Angular", category: "front-end"}
            ];
        ```
        

- Agora precisamos do serviço no componente:
    - No Angular, fazemos a partir da Injeção de Dependências:
        - Declarando a variável coursesService: CoursesService e inicializando ela no construtor do componente.
            
            ```tsx
            courses: Course[] = [];
              displayedColumns = ["name", "category"];
            
              coursesService: CoursesService;
            
              constructor() {
                this.coursesService = new CoursesService();
                this.courses = this.coursesService.list();
               }
            ```
            

> **Manipulação por exemplo do que será retornado no json(caso utilize json) é feita na classe de Serviço.**
> 

### Chamada ajax para fazer requisições

- **httpClient**
    - É necessário inserir uma variável do tipo HttpClient dentro do construtor do **Serviço**.
    - Para que assim, através da **injeção de dependência** o angular forneça-o automaticamente.
    

<aside>
📌 Quando criamos um Serviço no Angular, temos a anotação **@Injectable** e dentro dela o **provideIn: ‘’root”**, o que significa?

        - Que a instância dessa classe será fornecida apenas na **raiz** do projeto. Ficando assim, disponível de maneira global.

</aside>

Precisamos importar o módulo do HttpClient, porém deve ser feito no arquivo **app.module.ts** para que fique disponível de forma global.

Dentro do imports, inserimos o HttpClientModule.

Para instanciar o ItemsService de forma automátima no nosso Serviço, precisamos:

Em vez de instanciar e criar o coursesService, injetamos o **Serviço** diretamente no Componente, já que o Serviço possui a diretiva **@Injectable:**

```tsx
constructor(private CoursesService: CoursesService) {}
```

A partir do momento que declaramos a variável dentro do construtor, ela se torna uma variável da instância/do componente. Sendo assim dentro dela conseguimos acessar o CoursesService.

- Caso prefira que a instância seja feita apenas no momento em que o componente for inicializado, passamos ele para o **ngOnInit()**.
    - Dessa forma:
        
        ```
        ngOnInit(): void {
            this.courses = this.coursesService.list();
          }
        ```
        

### **Chamada HTTP Get no Angular e RXJS**

### **Debugar o RXJS Observables:**

- pipe significa “cano”. Usando operadores do RXJS para fazer a manipulação dos dados.
    
    ```
    list(){
        return this.httpClient.get<Course[]>(this.API)
        .pipe(
          tap(courses => console.log(courses))
        );
      }
    ```
    
    ### Adicionando o **Spinner (Carregando):**
    
    1. Importa o MatProgressSpinnerModule 
    
    ```
    import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
    ```
    
    1. A tag que vai no html:
    
    ```
    <mat-spinner></mat-spinner>
    ```
    
    - Agora precisamos informar que o **Spinner** irá aparecer até que o dados sejam carregados.
    - Para isso utilizamos o **pipe**.
        - O **pipe** no angular também serve para transformar os dados.
        - Anotação: **async**
        
    
    No HTML, insere:
    
    ```html
    *ng-if="courses | async as courses"
    ```
    
    O pipe async se inscreve dentro do Observable de courses.
    
    Ao mudar a rota da página e então o angular destruir ou deixar de utilizar o compoente, o angular faz o **unsubscribe** autmáticamente.
    
    Chamamos a variável de courses para que possamos utilizá-la depois.
    
    O método de listar tem um parâmetro chamado first(), dessa forma:
    
    ```tsx
    list(){
        return this.httpClient.get<Course[]>(this.API)
        .pipe(
          first(),
          tap(courses => console.log(courses))
        );
      }
    ```
    
    O que o **first()** faz é informar para o RXJS que assim que obter a primeira resposta, ele deve faz o **unsubscribe** automaticamente.
    
    - Anotação de **Observables**:
        - items$
        
    
    Se o observable ainda não retornou os dados, aparece o template de spinner-loading.
    
    Criamos o ng-template com um identificador: **#**(Indica que é itendificação)
    
    ```html
    <div *ngIf="courses$ | async as courses; else loading">
    </div>
    <ng-template #loading>
        <div class="loading-spinner">
          <mat-spinner></mat-spinner>
        </div>
      </ng-template>
    ```
    
    Precisamos também de um tratamento de erros, pois atualmente não temos um ponto de parada, portanto o spinner irá ficar rodando infinitamente caso a url que carrega os dados esteja com algum erro.
    
    ### Tratamento de Erros
    
    Quem trata o erro para exibir para o usuário no angular é **Component**.
    
    O RXJS tem um operador para tratamento de erros chamado **catchError**.
    
    ```tsx
    this.courses$ = this.coursesService.list()
        .pipe(
          catchError(error => {
            return of([]);
          })
        );
    ```
    
    Estamos retornando através da anotação **of()**, um observable de array vazio.
    
    Ou seja, quando no componente.html fizer a verificação “*ngIf="courses$ | async as courses”, vai retornar que existe uma informação, mesmo que vazia.
    
    **Inserindo uma popup para o usuário:**
    
    - No angular material, podemos usar um Dialog ou uma Snackbar, ou os dois.
    - A popup de erro pode ser útil em vários módulos diferentes, portanto vamos criar uma pasta de módulo para utilizar componentes compartilhados.
    - Criando o módulo de shared:
        - ng g m shared
    - Dentro do módulo criamos o componente:
        - ng g c shared/components/error-dialog
        
    - O componente será utilizado em vários módulos, portanto precisa ser exportado, no arquivo shared.module.ts:
        
        ```
        imports: [
            CommonModule
          ],
          exports: [ErrorDialogComponent]
        ```
        
        Importamos também o MatDialogModule no app-material.module.ts(arquivo de imports para organização do mesmo).
        
        Portanto precisamos importar esse arquivo no nosso mais novo módulo shared.module.ts
        
        * Estudar popup/dialog no angular *
        
        ### **Pipe para mostrar ícone**
        
        Material Design de icons: [https://fonts.google.com/icons](https://fonts.google.com/icons)
        
        1. Exporta o icons do Angular Material
            
            ```
            <mat-icon aria-hidden="false" aria-label="Example home icon" fontIcon="home"></mat-icon>
            ```
            
        2. Criaremos um  ícone diferente para cada categoria
            1. Existe um tipo especial de uma classe no angular chamada pipe, que fará a transformação do valor:
                1. Vamos criar um pipe dentro do módulo compartilhado
                    1. Comando: ng g pipe shared/pipes/category
        
        Esse novo tipo do angular, é uma classe que implementa uma interface do angular chamada **PipeTransform.**
        
        Geralmente são usadas em pipe, por usar funções diretas.
        
        O arquivo category.pipe.ts:
        
        ```tsx
        export class CategoryPipe implements PipeTransform {
          transform(value: string): string {
            switch(value){
              case 'front-end': return 'code';
              case 'back-end': return 'keyboard';
            }
            return 'code';
          }
        }
        ```
        
        code e keyboard são ícones do google fonts.
        
        O pipe criado, está visível apenas dentro do módulo shared. Precisamos exportar ele também no shared.module.ts.
        
        ```tsx
        exports: [
            ErrorDialogComponent,
            CategoryPipe
          ]
        ```
        
    
    ### Utilizando o pipe
    
    No arquivo category.pipe.ts temos o seu nome: 
    
    ```tsx
    @Pipe({
      name: 'category'
    })
    ```
    
    Lá no HTML, em vez de usarmos ‘home’, vamos utilizar o pipe → | e o nome do pipe → category:
    
    ```
    <td mat-cell *matCellDef="let course"> {{course.category}}
              <mat-icon aria-hidden="false" aria-label="Categoria do Curso">{{ course.category | category}}</mat-icon>
            </td>
    ```
    
     
    
    ## **Conectando o Angular na API Spring**
    
    ### Criar arquivo de proxy chamado proxy.conf.js
    
    No mesmo nível do package.json
    
    Dentro dele temos essa configuração:
    
    ```jsx
    **const PROX_CONFIG = [
      {
        context: ['/api'],
        target: 'http://localhost:8080/',
        secure: false,
        logLevel: 'debug'
      }
    ];
    
    module.exports = PROX_CONFIG;**
    ```
