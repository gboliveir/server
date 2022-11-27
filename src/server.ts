import express from 'express';
import cors from 'cors';

import { PrismaClient } from '@prisma/client';

const app = express();

app.use(express.json());
app.use(cors());

const prisma = new PrismaClient({
  log: ['query']
})

app.get('/customers', async (request, response) => {
  const customers = await prisma.customer.findMany({
    select: {
      id: true,
      status: {
        select: {
          id: true
        },
      },
      cnpj: true,
      name: true,
      phoneNumber: true,
      email: true,
      whatsapp: true
    }
  });

  return response.json(customers);
});


app.get('/filter/customer', async (request, response) => {
  const customerFilter = await prisma.customer.findMany({
    select: {
      id: true,
      name: true,
    }
  });

  return response.json(customerFilter);
});

app.get('/filter/cnpj', async (request, response) => {
  const cnpjFilter = await prisma.customer.findMany({
    select: {
      id: true,
      cnpj: true,
    }
  });

  return response.json(cnpjFilter);
});

app.get('/filter/status', async (request, response) => {
  const statusFilter = await prisma.status.findMany({
    select: {
      id: true,
      name: true
    }
  });

  return response.json(statusFilter);
});

app.post('/customer/contacts', async (request: any, response: any) => {
  const body = request.body;

  const message = await prisma.message.create({
    data: {
      description: body.description,
      email: body.email,
      name: body.name,
      phoneNumber: body.phoneNumber
    }
  });

  return response.status(201).json(message);
});

app.get('/auth', async (request: any, response: any) => {
  const body = request.data;

  console.log(request);

  const user = await prisma.customer.findFirst({
    where: {
      email: body.email
    },
    select: {
      name: true,
      email: true,
      password: true,
      cheatedAt: true,
    }
  });

  if (!user || user.password !== body.password) {
    return (
      response.status(207).json({
        title: 'Usuário não identificado',
        message: 'Suas informações estão incorretas ou seu cadastro ainda não foi realizado no sistema'
      }
    ));
  }

  const { password, ...rest } = user;

  return response.status(201).json(rest);
});

app.listen(3333);