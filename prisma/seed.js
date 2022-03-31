const { PrismaClient } = require('@prisma/client');
const { create } = require('json-server');
const prisma = new PrismaClient();

async function seed() {
    const createdCustomer = await prisma.customer.create({
        data: {
            name: "Alice",
            contact: {
                create: {
                    phone: 0999955599,
                    email: "email@email.com",
                },
            },
        },
        include: {
            contact: true,
        },
    });

    console.log('Customer created', createdCustomer);

    const createdMovie = await prisma.movie.create({
        data: {
            title: 'Titanic',
            runtimeMins: 180,
            Screening: {
                create: {
                    startsAt: new Date(1998, 0, 23, 10, 05, 0, 0)
                }
            }
        },
        include: {
            Screening: true
        }

    })


    console.log('add movie', createdMovie)


    // Don't edit any of the code below this line
    process.exit(0);
}

seed()
    .catch(async (error) => {
        console.error(error);
        await prisma.$disconnect();
        process.exit(1);
    })
