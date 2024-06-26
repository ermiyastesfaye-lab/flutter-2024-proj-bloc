import { Role } from "@prisma/client"
import { IsEmail, IsOptional, IsString } from "class-validator"

export class EditUserDto {
    @IsEmail()
    @IsOptional()
    email?: string

    @IsString()
    @IsOptional()
    role?: Role
}