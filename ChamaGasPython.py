
import psycopg2

#connect to the db 
con = psycopg2.connect(host="127.0.0.1",
                    database='chamagas', 
                    user='postgres',
                    password='oi')
con.autocommit = True
#cursor 
mycursor = con.cursor()
#cur.execute("select distinct nome_c, count(id_pedido), nome_r from CLIENTE natural join REVENDEDOR natural join PEDIDO group by nome_c, nome_r order by nome_c")




class consulta1(Exception):
    pass   
class consulta2(Exception):
    pass   
class consulta3(Exception):
    pass   
class consulta4(Exception):
    pass   
class consulta5(Exception):
    pass   
class consulta6(Exception):
    pass   
class consulta7(Exception):
    pass   
class consulta8(Exception):
    pass   
class consulta9(Exception):
    pass   
class consulta10(Exception):
    pass   
def loop():
    num =input("\nQual das 10 consultas? ")
    try:
        if num=="1":
            raise consulta1
        elif num=="2":
            raise consulta2
        elif num=="3":
            raise consulta3
        elif num=="4":
            raise consulta4
        elif num=="5":
            raise consulta5
        elif num=="6":
            raise consulta6
        elif num=="7":
            raise consulta7
        elif num=="8":
            raise consulta8
        elif num=="9":
            raise consulta9
        elif num=="10":
            raise consulta10
        else:            
            rua =input("\nPara exemplo de inserção de endereço, digite uma rua: ")
            nro =int(input("\nE o número da casa: "))
            id =int(input("\nE um id: "))
            mycursor.execute("""
                INSERT INTO ENDERECO (id_endEntrega, rua_entrega, num_entrega, bairro_entrega, cidade_entrega, compelemento_entrega, uf_entrega)
                VALUES (%(int1)s, %(str2)s, %(int3)s, %(str4)s, %(str5)s, %(str6)s, %(str7)s);
                """,
                {'int1': id, 'str2': rua, 'int3': nro, 'str4': 'Centro', 'str5': 'Baianópolis', 'str6': 'Mercado', 'str7': 'BA'})
            sql = "SELECT *\
            from ENDERECO"
            mycursor.execute(sql)
            myresult = mycursor.fetchall()
            for x in myresult:
                print(x) 
            return 0
    except consulta1 as e:
        print("O nome de cada cliente, revendedores ligados a ele, e a quantidade de pedidos que ele realizou para cada revendedor ligado a si")
        sql = "SELECT \
        empresa, \
        count(nome_r) \
        from REVENDEDOR \
        group by empresa \
        having count(nome_r) = (select max(maxREV) from (select empresa, count(nome_r) \
        maxREV from REVENDEDOR group by empresa) as maxREV)"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta2 as e:
        print("Revendedores que venderam R$90 ou mais (juntando todos os pedidos) em dinheiro, e o quanto venderam")
        sql = "SELECT \
        nome_r, \
        sum(totalApagar)  \
        from REVENDEDOR \
        natural join PEDIDO natural join PAGAMENTO WHERE tipo_Pag = 'dinheiro' \
        group by nome_r having sum(totalApagar) >= 90.00"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta3 as e:
        print("Nome dos clientes que fizeram pedidos em dinheiro e pedidos em cartão de crédito")
        sql = "SELECT \
        distinct nome_c \
        from CLIENTE \
        natural join PEDIDO natural join PAGAMENTO where tipo_Pag = 'dinheiro' \
        and num_tel in (select num_tel from PEDIDO natural join PAGAMENTO where tipo_Pag = 'credito')"	
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta4 as e:
        print("Revendedores que antenderam Mariana Silva e Carlos Lopes")
        sql = "SELECT \
        distinct nome_r \
        from REVENDEDOR \
        natural join PEDIDO natural join CLIENTE where nome_c = 'Mariana Silva'\
        and nome_r in (select distinct nome_r from PEDIDO natural join CLIENTE where nome_c = 'Carlos Lopes')"	
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta5 as e:
        print("Para clientes que fizeram pedidos em dinheiro e pedidos em cartão de credito, o nome do cliente, tipo de pagamento da compra de maior valor, e este valor")
        sql = "SELECT \
        nome_c, \
        tipo_Pag, \
        max(totalApagar) \
        from PEDIDO \
        natural join PAGAMENTO natural join CLIENTE where tipo_Pag = 'credito'\
        and num_tel in (select num_tel from PEDIDO natural join PAGAMENTO where tipo_Pag = 'dinheiro') \
        group by nome_c, tipo_Pag"	
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta6 as e:
        print("Clientes de Porto Alegre que não foram atendidos por nenhum dos revendedores que atenderam Mariana Silva ")
        sql = "SELECT \
        nome_c \
        from CLIENTE \
        as EXC natural join ENDERECO where cidade_entrega = 'Porto Alegre'\
        and not exists (select nome_r from REVENDEDOR natural join PEDIDO \
        natural join CLIENTE where nome_c = 'Mariana Silva' and nome_r in \
        (select nome_r from REVENDEDOR natural join PEDIDO natural join CLIENTE where nome_c = EXC.nome_c))"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta7 as e:
        print("O número total de pedidos finalizados em dinheiro, o número total de pedidos finalizados em cartão de crédito ou debito")
        sql = "SELECT \
        Pagamento_Por, \
        count(Pagamento_Por) \
        from NO_HISTORICO \
        where Pagamento_Por > 'carteira' group by Pagamento_Por"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta8 as e:
        print("Empresa mais famosa entre os compradores; ou seja, a empresa que tem mais pedidos realizados/efetuados, e o número de pedidos")
        sql = "SELECT \
        Tipo_Gas, \
        count(Tipo_Gas) \
        from NO_HISTORICO \
        group by Tipo_Gas \
        having count(Tipo_Gas) = (select max(maxEMPRESA) from (select Tipo_Gas, count(Tipo_Gas) \
        maxEMPRESA from NO_HISTORICO group by Tipo_Gas) as maxEMPRESA)"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta9 as e:
        print("Estados que ainda não possuem revendedores")
        sql = "SELECT \
        UF_entrega \
        from ENDERECO \
        where UF_entrega not in (select distinct UF_r from Referenciar natural join REVENDEDOR)"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()
    except consulta10 as e:
        print("Empresas que possuem mais revendedores")
        sql = "SELECT \
        empresa, \
        count(nome_r) \
        from REVENDEDOR \
        group by empresa \
        having count(nome_r) = (select max(maxREV) from (select empresa, count(nome_r) \
        maxREV from REVENDEDOR group by empresa) as maxREV)"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        for x in myresult:
            print(x) 
        loop()

print("Chama gás\nNomes: Izadora e Milena")


loop()

#close the cursor
mycursor.close()

#close the connection
con.close()

