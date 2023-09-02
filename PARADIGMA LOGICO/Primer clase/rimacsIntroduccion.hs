data Casa = Casa {
    direccion::String,
    vendedores:: [String]
}

inia = "Inia";
martin = "Martin";
siempreViva = Casa "Siempre viva 742" [inia, martin]
miCasita =  Casa "Micasita 123" [inia]

casasEnVenta = [siempreViva, miCasita]

-- Es cierto que alguien vende una casa

vende::String -> String -> [Casa] -> Bool

vende vendedor unaDireccion = any (laCasatieneDireccionYVendedor vendedor unaDireccion)


laCasatieneDireccionYVendedor:: String -> String -> Casa -> Bool
laCasatieneDireccionYVendedor vendedor unaDireccion casa =  (direccion casa == unaDireccion) && elem vendedor (vendedores casa)

-- Que casas vende cierta persona

queVende :: String -> [Casa] -> [String]
queVende vendedor = map direccion.filter (elem vendedor.vendedores)

--Quienes venden cierta casa
quienesVenden :: String -> [Casa] -> [String]
quienesVenden unaDireccion =  vendedores.head.filter ( (== unaDireccion).direccion)

-- Es cierto que una persona vende alguna casa
vendeAlgo:: String -> [Casa] -> Bool
vendeAlgo vendedor = any (elem vendedor.vendedores)

-- Es cierto que una casa existe (esta en venta)
seVende :: String -> [Casa] -> Bool
seVende unaDireccion = any ((==unaDireccion).direccion)