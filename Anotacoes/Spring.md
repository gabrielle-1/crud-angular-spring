# Spring

Created: August 23, 2022 8:11 PM
Definition: Spring WEB - API
Spring DATA - BD
Spring Security - Security
Spring CLOUD - Microsserviços
Reviewed: No

- [ ]  Adicionar Exceptions
- [ ]  

model → entidades

### Injeção de Dependência e Inversão de Controle

New → Dependência

[Mapeamento (@RestController e @ResponseBody)](https://www.notion.so/Mapeamento-RestController-e-ResponseBody-696de8daa84d450fb2c0c06afd652a1b)

### Anotações

- O Spring Boot é baseado em **anotações**.
- São funcionalidades introduzidas no Spring a partir da versão 2.5, possibilitando aos desenvolvedores um aumento significativo em produtividade. Isto se deve à facilidade de configuração via anotações, o que era mais complicado nas versões anteriores do Spring, pois toda configuração era via XML.

Entidades → **@Entity**

Utilizada para informar que uma classe também é uma entidade.

A partir disso, a JPA estabelecerá a ligação entre a entidade e uma tabela de mesmo nome no banco de dados, onde os dados de objetos desse tipo poderão ser persistidos.

<aside>
💡 ***Nota:** A anotação **@Entity** faz parte do pacote de persistência do Java: javax.persistence.*

</aside>

- São o nosso model, ou seja, o objeto que será manipulado. No nosso exemplo de lista de tarefas seria a Task(tarefa)

Podemos alterar o nome da entidade:

```java
@Entity(name="EntidadeProduto”) 
public class Produto(){}   
```

- Criação da entidade Task:

```
@Entity // Entidade de dados
@Table(name="tasks") // Nome da tabela
@Setter // Métodos de Setter
@Getter // Métodos de Getter
@ToString // Método toString
```

- Campo Id:

```
@Id // Identificador
@GeneratedValue(strategy = GenerationType.IDENTITY)// Gera valores com auto incremento
private long id;
```

- Valores como titulo, descrição(que podem ser nulos ou não):

```
@Column(nullable = false) // Não pode ser nula
private String title;
@Column(nullable = true) // Pode ser nula
private String description;
```

- Valores de create(criação) e update(atualização) do registro no banco de dados:

```
@Column(nullable = false)
private Date deadLine;

@CreationTimestamp
@Column(name = "created_at", nullable = false, updatable = false)
private Date createdAt;

@UpdateTimestamp
@Column(name = "updated_at")
private Date updatedAt;
```

### Configurações **H2 Database**:

No arquivo **application.properties**:

```
spring.h2.console.enabled=true

spring.datasource.url=jdbc:h2:mem:todolist
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=gabrielle
spring.datasource.password=

spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=update
```

### Configurações PostgreSQL:

```
spring.datasource.url=${JDBC_DATASOURCE_URL}
spring.jpa.show-sql=true
spring.jpa.generate-ddl=true
server.port=${PORT:8080}

spring.datasource.driverClassName=org.postgresql.Driver
spring.datasource.maxActive=10
spring.datasource.maxIdle=5
spring.datasource.minIdle=2
spring.datasource.initialSize=5
spring.datasource.removeAbandoned=true

spring.mvc.pathmatch.matching-strategy=ant_path_matcher
```

No browser: localhost:8080/h2-console

### Repositório → @Repository

- Definir uma classe como pertencente à camada de persistência(faz parte também junto com a @Entity).

```java
Interface TaskRepository extends JpaRepository(){}
```

O Spring Data JPA precisa entender que essa é a classe responsável pela comunicação entre a camada de modelo(task) e o banco de dados. (Métodos como save, find, etc) 

<aside>
💡 **Controller** chama **Service** chama **Repository** chama **Camada de dados** chama **Banco**

</aside>

## @Service

- Anotação que serve para definir uma classe como pertencente à camada de Serviço da aplicação.
- Utiliza o Repository como variável para usar os métodos de listar, salvar, etc.

```java
@Service
@RequiredArgsConstructor
public class TaskService {

@Autowired
    private TaskRepository taskRepository;

		public List<Task> list(){
        return this.taskRepository.findAll();
    }
}
```

## Controller

- Mapeamento das rotas

```

@RestController
@RequestMapping("/api/v1")
public class TaskController {

    @Autowired
    TaskService taskService;
	
		@GetMapping("/tasks")
    @ResponseStatus(HttpStatus.OK)
    public List<Task> getAllTasks(){
        return this.taskService.list();
    }
}

```

PUT  e DELETE

ERROS

[https://stackoverflow.com/questions/40241843/failed-to-start-bean-documentationpluginsbootstrapper-in-spring-data-rest](https://stackoverflow.com/questions/40241843/failed-to-start-bean-documentationpluginsbootstrapper-in-spring-data-rest)

### Passando para PostgreSQL do Heroku

```
spring.datasource.url=${JDBC_DATASOURCE_URL}
spring.jpa.show-sql=true
spring.jpa.generate-ddl=true
server.port=${PORT:8080}

spring.datasource.driverClassName=org.postgresql.Driver
spring.datasource.maxActive=10
spring.datasource.maxIdle=5
spring.datasource.minIdle=2
spring.datasource.initialSize=5
spring.datasource.removeAbandoned=true

```

Parabéns!!! Conseguimos!

[https://todolist-crud-gabrielle.herokuapp.com/swagger-ui.html](https://todolist-crud-gabrielle.herokuapp.com/swagger-ui.html)

maven → versões do maven aceita pelo heroku:

- 3.2.5
- 3.3.9
- 3.5.4
- 3.6.2

Podemos também especificar essa informação no system.properties:

`maven.version=3.6.2`

### Possíveis erros:

1. **Erro de versão do Maven aceita pelo Heroku:**
    
    <aside>
    ⚠️ CoreException: Could not get the value for parameter compilerId for plugin execution default-compile: PluginResolutionException: Plugin org.apache.maven.plugins:maven-compiler-plugin:3.8.0 or one of its dependencies could not be resolved: Failed to collect dependencies at org.apache.maven.plugins:maven-compiler-plugin:jar:3.8.0
    
    </aside>
    
    link versões aceitas Maven:
    
    [https://devcenter.heroku.com/articles/deploying-java-applications-with-the-heroku-maven-plugin](https://devcenter.heroku.com/articles/deploying-java-applications-with-the-heroku-maven-plugin)
    
2. “****Failed to start bean nested exception is java.lang.NullPointerException: Cannot invoke”****
    
    Falta a notação @Bean
    
    Caso inseriu a anotação e o erro persistiu:
    
    Motivo:Mudança que entrou na versão 2.6 do Spring Boot.
    
    Resolução: Adicione essa linha no application.properties que resolve: `spring.mvc.pathmatch.matching-strategy=ant_path_matcher`
    
3. 

### GitHub

README: [https://www.youtube.com/watch?v=jIa8R69pKh8](https://www.youtube.com/watch?v=jIa8R69pKh8)

Exemplo de README : [https://github.com/devsuperior/sds1-wmazoni#readme](https://github.com/devsuperior/sds1-wmazoni#readme)

Shields: [https://shields.io](https://shields.io/)

Maven download:

[https://repo.maven.apache.org/maven2/org/apache/maven/maven/](https://repo.maven.apache.org/maven2/org/apache/maven/maven/)

Maven dependências : [https://mvnrepository.com/artifact/org.springframework.boot/https://mvnrepository.com/artifact/org.springframework.boot/](https://mvnrepository.com/artifact/org.springframework.boot/) 

## Testes Unitários